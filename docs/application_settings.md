## How to use application settings

The feature is based on gem mokio_custom_settings.

### Setup defaults:

In `mokio.rb` you can set defaults settings using `application_settings_defaults`.
For example:

```
  config.application_settings_defaults = [
    {
      name: 'custom_email',
      value: 'test@test.com',
      description: 'Some desc',
      deletable: 'false',
      group: 'Defaults'
    }
  ]
```

### How to fetch data:
To find some value you can use service:
```
Mokio::Services::FindAppSetting.new(name, default_value = nil, search_default_in_config = true).call
Mokio::Services::FindAppSetting.new('custom_email).call
```
or
```
Mokio::ApplicationSetting.where(name: 'custom_email').first&.value
```
