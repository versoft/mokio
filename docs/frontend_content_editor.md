## Frontend content editor
#### How to setup:
1. In your application's helper create method:
```
  def editable_block(block_params, &block)
    block_text = capture(&block)
    block_params[:path] = request.path
    Mokio::FrontendEditor::EditorField.new(
      current_user,
      block_params,
      block_text,
      I18n.locale.to_s
    ).process_block
  end
```
2. In layout add before body close:
```<%= Mokio::FrontendEditor::EditorPanel.new(current_user).render_editor_panel %>```
3. In your template create `editable_block` like this:
```
<%= editable_block({id: 'blockTextId'}) do %>
  <div>to jest div</div>
<% end %>
```
In `blockTextId` add unique text/hash to identify block.
You can use task to generate hashes: `rails mokio:editable_blocks_ids`
4. If you want reduce number of SQL queries you can fetch all blocks in controller using code:
```
@blocks = Mokio::EditableBlock.find_blocks_by_lang_and_location(
  I18n.locale.to_s, request.path
)
```
And then update block:
```<%= editable_block({ id: 'fc28cafb81230c', blocks: @blocks }) do %>```

#### Important:
- blocks are saved with locale. One block can have multiple versions based on passed locale

