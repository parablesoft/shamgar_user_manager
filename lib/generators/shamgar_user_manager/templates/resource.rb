<% module_namespacing do -%>
class <%= class_name.singularize %>Resource < JSONAPI::Resource

  attributes :email, :first_name, :last_name, :full_name, :role,:created_at,:last_sign_in_at,:confirmed_at,:confirmed?,:disabled?

  def self.creatable_fields(context)
    [:first_name,:last_name,:email,:role]
  end

  def self.updatable_fields(context)
    [:first_name,:last_name,:email,:role]
  end


  filter :disabled, apply: ->(records,value,_options){
    value.first == "true" ? records.with_deleted : records 
  }
end
<% end -%>
