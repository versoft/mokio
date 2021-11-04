## How to setup CKEditor fields

CKEditor 4 is the default. If you want to turn on CKEditor5 you have to:
1. Ensure that you are using Mokio at least in Version 2.10.0
2. In `config/initializers/mokio.rb` add two variables:\
Path to store uploaded files via MokioFileBrowser:\
`config.cke_root_images_path = 'public/cke-files'`\
Turn on CKEditor 5:\
`config.use_ckeditor5 = true`

### Adding new CKEditor field in a form:
To add CKEditor field you have to use helper `render_ckeditor_field`.\
There are three versions of `ckeditor_name`: Mini, Medium, Full.\
Some examples of use:
```
  = render_ckeditor_field(f, { input_name: :content, ckeditor_name: 'Medium' })
  = render_ckeditor_field(f, { input_name: :intro, ckeditor_name: 'Mini', ckeditor_height: 150 })
  = render_ckeditor_field(f, { input_name: :intro, value: @obj.value, ckeditor_name: 'Mini', ckeditor_height: 150 })
```
Supported parameters:
1. input_name - the name of model field
2. ckeditor_name - CKEditor variant: Mini / Medium /Full
3. ckeditor_height - CKEditor field height in px
4. disabled - init CKEditor editor as readonly
5. value - set initial value
6. label - set label

"ckeditor_height" - for CKEditor5 is not required. Without it a form field will autoscale to the content.

### How to change toolbars
Whole CKEditor5 config is here: [ckeditor5.js](../app/assets/javascripts/backend/ckeditor5.js)\
If you want to change toolbars settings you have to overwrite `ckeditor5.js`.\
In your project create file `app/assets/javascripts/backend/ckeditor5.js` and copy content from the repository.

### Update project with CKEditor4 to CKEditor5
1. Check is correct Mokio's version
2. Setup config in `mokio.rb` for CKEditor5
3. Check overwritten `_form` with inputs textarea. Change them to `render_ckeditor_field`
