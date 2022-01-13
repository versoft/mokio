## Additional partials in index views

### How to use
In your view directory for example: `app/views/mokio/articles` you can use two partials:
1. `_index_buttons.html.slim` - render next to button 'Add new'
2. `_index_desc.html.slim` - render in `div.content.noPad.clearfix` before the search input

Any templates formats are supported (.slim, .erb, etc.)

### Sample content of the `_index_buttons.html.slim`
```
a href="#"
  button.btn.btn-primary.btn-mini Button primary

a href="#"
  button.btn.btn-mini Button

a href="#"
  button.btn.btn-warning.btn-mini Button warning

a href="#"
  button.btn.btn-danger.btn-mini Button danger

a href="#"
  button.btn.btn-success.btn-mini Button success

a href="#"
  button.btn.btn-info.btn-mini Button info

a href="#"
  button.btn.btn-inverse.btn-mini Button inverse

```

### Sample content of the `_index_desc.html.slim`
```
div.index-desc-content
  h4 Lorem ipsum
  p Lorem ipsum dolor sit amet, consectetur adipiscing elit,
    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
    reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
    pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
    culpa qui officia deserunt mollit anim id est laborum
  a href="#"
  button.btn.btn-danger.btn-mini Button danger
```
