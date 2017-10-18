require "spec_helper"

describe User, type: :model do

  subject! {create(:user)}

  describe "#destroy" do
    it{expect{subject.destroy}.to change{User.count}.by(-1)}


    it "soft deletes the record" do
      subject.destroy
      expect(User.only_deleted.count).to eq(1)
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
