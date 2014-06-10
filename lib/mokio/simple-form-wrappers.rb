require 'simple_form'

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.

 # =========================================================================================== #

  config.wrappers :custom, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span10' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper =  :custom

  config.wrappers :custom_without_label, :tag => 'div', :class => 'row-fluid text-center', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span10' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

 # =========================================================================================== #

  config.wrappers :active_checkbox, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'activebutton' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'span', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

 # =========================================================================================== #

  config.wrappers :date, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span2' do |ba|
      ba.use :input, :wrap_with => { :tag => 'div', :class => 'input-append' }
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

 # =========================================================================================== #

   config.wrappers :checkbox, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span8 controls' do |ba|
      ba.use :input, :wrap_with => { :tag => 'div', :class => 'left marginT5' }
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

# =========================================================================================== #

  config.wrappers :ckeditor, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span10 ckeditor' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

# =========================================================================================== #

  config.wrappers :append, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span2' }
    b.wrapper :tag => 'div', :class => 'span9' do |ba|
      ba.use :input, :wrap_with => { :tag => 'div', :class => 'input-append' }
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

   config.wrappers :label_newline, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span12' }
    b.wrapper :tag => 'div', :class => 'span12' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

   config.wrappers :input_span, :tag => 'div', :class => 'row-fluid', :error_class => 'error' do |b|
    b.use :html5
    b.use :maxlength
    b.use :placeholder
    b.use :readonly

    b.use :label_text, :wrap_with => { :tag => 'label', :class => 'form-label span4' }
    b.wrapper :tag => 'div', :class => 'span4' do |ba|
      ba.use :input
      ba.use :error, :wrap_with => { :tag => 'label', :class => 'error' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end
end
