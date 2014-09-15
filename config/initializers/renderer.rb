ActionView::Renderer.class_eval do
  def render(context, options)
    content = options.key?(:partial) ? render_partial(context, options) : render_template(context, options)
    Mokio::TemplateRenderer.render content, context, options, self
  end
end