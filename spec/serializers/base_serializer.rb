require 'jsonapi-serializers'
class BaseSerializer
  include JSONAPI::Serializer

  def self_link
    nil
  end


end
