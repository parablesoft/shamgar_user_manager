require "spec_helper"

describe User, type: :model do

  subject! {create(:user)}



  context "validations" do
    it{is_expected.to validate_presence_of :first_name}
    it{is_expected.to validate_presence_of :last_name}
    it{is_expected.to validate_presence_of :email}
    it{is_expected.to validate_presence_of :role}
  end

  describe "#authentication_token" do
    it "is set when the record is created" do
      expect(subject.authentication_token).not_to be_nil
    end
  end

  describe "#change_authentication_token!" do
    it{expect{subject.change_authentication_token!}.to change{subject.authentication_token}}
  end



  describe "#admin?" do

    context "is admin" do

      it "is true when role is admin" do
	subject.role = "admin"
	expect(subject.admin?).to be_truthy
      end

      it "is true and is not case sensitive" do
	subject.role = "AdMiN"
	expect(subject.admin?).to be_truthy
      end
    end

    context "is not admin" do

      it "has a role that is not admin" do
	subject.role = "foobar"
	expect(subject.admin?).to be_falsy
      end

      it "does not have a role" do
	subject.role = nil
	expect(subject.admin?).to be_falsy
      end
    end

  end


  describe "scopes" do
    before do
      subject.destroy
      create_list(:user, 3, confirmed_at: nil)
      create_list(:user, 2, confirmed_at: DateTime.now)
    end

    it{expect(User.unconfirmed.count).to eq(3)}
    it{expect(User.confirmed.count).to eq(2)}
  end


  describe "#destroy" do
    it{expect{subject.destroy}.to change{User.count}.by(-1)}


    it "soft deletes the record" do
      subject.destroy
      expect(User.only_deleted.count).to eq(1)
    end

    it "changes the authentication_token" do
      expect{subject.destroy}.to change{subject.authentication_token}
    end
  end

  describe "#restore" do
    it "restores the record" do
      subject.destroy
      record = User.only_deleted.find(subject.id)
      expect{record.recover}.to change{User.count}.by(1)
    end
  end

  describe "#full_name" do
    it{expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")}
  end

  describe "#confirmed?" do
    context "is confirmed" do
      it "returns true when confirmed at is nil" do
	subject.confirmed_at = DateTime.now
	expect(subject.confirmed?).to be_truthy
      end
    end

    context "is not confirmed" do
      it "returns false when confirmed at is nil" do
	subject.confirmed_at = nil
	expect(subject.confirmed?).to be_falsy
      end


    end

  end


  describe "#unconfirmed?" do
    context "is confirmed" do
      it "returns false when confirmed at is nil" do
	subject.confirmed_at = DateTime.now
	expect(subject.unconfirmed?).to be_falsy
      end
    end

    context "is not confirmed" do
      it "returns true when confirmed at is nil" do
	subject.confirmed_at = nil
	expect(subject.unconfirmed?).to be_truthy
      end


    end

  end

  describe "#disabled?" do

    context "is not disabled" do
      it "returns false" do
	subject.deleted_at = nil
	expect(subject.disabled?).to be_falsy
      end

    end

    context "is disabled" do
      it{expect{subject.destroy}.to change{subject.disabled?}.to be_truthy}
      it "returns true" do

	subject.deleted_at = DateTime.now
	expect(subject.disabled?).to be_truthy
      end

    end

  end
end
