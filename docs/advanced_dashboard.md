## Advanced Dashboard

### Setup
1. Add in `config/initializers/mokio.rb` config:
  - enable advanced dashboard:
	```
	config.mokio_advanced_dashboard_enabled = true
	```

  - config for advanced dashboard:
	```
	config.mokio_advanced_dashboard_models = {}
	```

    example:

    ```
    config.mokio_advanced_dashboard_models ={
      "Mokio::PicGallery" => {
        "columns" => ['intro','active'],
        'actions' => true,
        'translations' => {
          "title_msg" => "Title",
          "label_msg" => "Label",
          "more" => "More"
        }
      }
    ```