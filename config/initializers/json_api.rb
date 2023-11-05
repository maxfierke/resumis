ActiveSupport.on_load(:action_controller) do
  require 'active_model_serializers/register_jsonapi_renderer'
end

ActiveModelSerializers.config.use_sha1_digests = true
ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.jsonapi_resource_type = :singular
ActiveModelSerializers.config.key_transform = :unaltered
ActiveModelSerializers::Model.derive_attributes_from_names_and_fix_accessors
