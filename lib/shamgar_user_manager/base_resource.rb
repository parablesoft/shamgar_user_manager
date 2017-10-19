module ShamgarUserManager
  class BaseResource < JSONAPI::Resource

    DEFAULT_ATTRIBUTES = [:first_name,:last_name,:email,:role] 
    DEFAULT_CREATABLE_ATTRIBUTES = [:first_name,:last_name,:email,:role]
    DEFAULT_UPDATABLE_ATTRIBUTES = [:first_name,:last_name,:email,:role]

    attributes(*DEFAULT_ATTRIBUTES)

    class_attribute :additional_creatable_attributes
    class_attribute :additional_updatable_attributes


    def self.add_attributes(*extra_attributes)
      attributes(*extra_attributes)
    end

    def self.add_creatable_attributes(*attributes)
      self.additional_creatable_attributes = attributes
    end

    def self.add_updatable_attributes(*attributes)
      self.additional_updatable_attributes = attributes
    end

    filter :disabled, apply: ->(records,value,_options){
      value.first == "true" ? records.with_deleted : records 
    }


    def self.creatable_fields(context)
      fields = DEFAULT_CREATABLE_ATTRIBUTES
      fields += self.additional_creatable_attributes if self.additional_creatable_attributes
      fields
    end

    def self.updatable_fields(context)
      fields = DEFAULT_UPDATABLE_ATTRIBUTES
      fields += self.additional_updatable_attributes if self.additional_updatable_attributes
      fields
    end

  end
end
