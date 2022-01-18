module Mokio
  module Services
    class FindAppSetting

      def initialize(name, default_value = nil, search_default_in_config = true)
        @name = name
        @default_value = default_value
        @search_default_in_config = search_default_in_config
      end

      def call
        value = Mokio::ApplicationSetting.where(name: @name).first&.value
        # return value if is present
        return value if value.present?

        # return default value if passed
        return @default_value if @default_value

        # search default value in config
        if @search_default_in_config
          data = Mokio.application_settings_defaults.find {
            |setting| setting[:name] == @name
          }
          return data[:value] if data
        end
      end

    end
  end
end
