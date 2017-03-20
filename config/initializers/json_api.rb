ActiveSupport.on_load(:action_controller) do
  require 'active_model_serializers/register_jsonapi_renderer'
end

ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.jsonapi_resource_type = :singular
ActiveModelSerializers.config.key_transform = :unaltered