require "spec_helper"
describe UserResource do


  let(:model){create(:user,:confirmed)}
  subject {UserResource.new(model,nil)}

  it { expect(described_class).to be < JSONAPI::Resource}

  it{ expect(subject.first_name).to eq model.first_name}
  it{ expect(subject.last_name).to eq model.last_name}
  it{ expect(subject.full_name).to eq model.full_name}
  it{ expect(subject.email).to eq model.email}
  it{ expect(subject.role).to eq model.role}
  it{ expect(subject.confirmed_at).to eq model.confirmed_at}
  it{ expect(subject.confirmed?).to eq model.confirmed?}
  it{ expect(subject.disabled?).to eq model.disabled?}
  it{ expect(subject.last_sign_in_at).to eq model.last_sign_in_at}
  it{ expect(subject.created_at).to eq model.created_at}



  describe "creatable fields" do
    context "default configuration" do
      before do
	class UserResource

	end
      end
      it "allows the right fields to be posted in a create" do
	fields = [:first_name,:last_name,:email,:role]
	expect(subject.class.creatable_fields(nil)).to match_array fields
      end


      it "allows the right fields to be patched in an update" do
	fields = [:first_name,:last_name,:email,:role]
	expect(subject.class.updatable_fields(nil)).to match_array fields
      end
    end


    context "add_creatable_attributes and add_updatable_attributes configuration" do
      before do
	class UserResource
	  add_creatable_attributes :foo
	  add_updatable_attributes :foo
	end
      end

      it "allows the right fields to be posted in a create" do
	fields = [:first_name,:last_name,:email,:role,:foo]
	expect(subject.class.creatable_fields(nil)).to match_array fields
      end

      it "allows the right fields to be patched in an update" do
	fields = [:first_name,:last_name,:email,:role,:foo]
	expect(subject.class.updatable_fields(nil)).to match_array fields
      end
    end
  end
end
