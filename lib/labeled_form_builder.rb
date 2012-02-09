class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  # VERSION 1: What the intern did...
  # def text_field(field_name, *args)
  #   @template.content_tag(:p, label(field_name) + "<br />".html_safe + super)
  # end
  # 
  # def select(field_name, *args)
  #   @template.content_tag(:p, label(field_name) + "<br />".html_safe + super)
  # end
  # 
  # def check_box(field_name, *args)
  #   @template.content_tag(:p, label(field_name) + "<br />".html_safe + super)
  # end
  # 
  # def submit(field_name, *args)
  #   @template.content_tag(:p, label(field_name) + "<br />".html_safe + super)
  # end
  
  # VERSION 2: A little more DRY
  %w[text_field select check_box submit].each do |method_name|
    define_method(method_name) do |field_name, *args|
      @template.content_tag(:p, label(field_name) + "<br />".html_safe + super(field_name, *args))
    end
  end
  
  
end