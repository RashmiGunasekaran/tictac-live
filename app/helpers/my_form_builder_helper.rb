module MyFormBuilderHelper
  def custom_check_box(method, tag_value, options = {})
   @template.content_tag(:div,
     @template.check_box(
       @object_name, method, tag_value, objectify_options(options)
     )
   )
 end
end
