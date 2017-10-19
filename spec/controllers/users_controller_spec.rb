require "spec_helper"

describe UsersController, type: :controller do

  before do
    class UsersController 
      self.resource = User
    end
  end


  describe "#index" do
    context "filtering" do

      before do 
	create_list(:user, 3, deleted_at: nil)
	create_list(:user, 2, deleted_at: DateTime.now)
      end

      def get_records(filter)
	get :index, params: {filter: filter}
      end

      context "disabled" do

	before do |example|
	  filter = example.metadata[:filter]
	  get_records(filter)
	end

	it "gets the disabled users as well as the active users",filter: {disabled: true} do
	  expect(json_body[:data].length).to eq(5)
	end

	it "gets only the active users", filter: {disabled: false} do
	  expect(json_body[:data].length).to eq(3)
	end
      end
    end
  end

  describe "resource_klass" do
    it{expect(subject.resource_klass).to eq(User)}


    context "alt class" do
      before do

	class UsersController 
	  self.resource = AltUserClass
	end
      end
      it "allows the resource class to be specified" do
	expect(subject.resource_klass).to eq(AltUserClass)
      end
    end


  end



  describe "#valid_email" do
    let!(:email_in_use){create(:user).email}

    before do
      post :valid_email, params: {email: email}, format: "json"
    end

    context "email is not in use" do
      context "valid unused email" do
	let(:email){"foo@bar.com"}
	it{expect(json_body[:is_valid]).to be_truthy}
      end

      context "invalid email address that is not being used" do
	let(:email) {"fadfjasdklf"}
	it{expect(json_body[:is_valid]).to be_falsy}
      end
    end

    context "email is in use" do
      let(:email){email_in_use}
      it{expect(json_body[:is_valid]).to be_falsy}
    end

  end

  describe "#enable" do
    let(:model) {create(:user,:confirmed)}

    before do
      model.destroy
    end

    def do_enable
      post :enable, params: {id: model.id}
    end

    it{expect{do_enable}.to change{User.count}.by(1)}
  end





end
