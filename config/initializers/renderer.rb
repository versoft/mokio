ActionView::Renderer.class_eval do
  def render(context, options)
    content = options.key?(:partial) ? render_partial(context, options) : render_template(context, options)
    Mokio::FrontendHelpers::TemplateHelper.render content, context, options, self
  end
end