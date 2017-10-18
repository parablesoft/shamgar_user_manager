require "spec_helper"

describe UsersController, type: :controller do

  describe "#is_valid" do
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

  end




end
