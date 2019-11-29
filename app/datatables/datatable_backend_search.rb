class DatatableBackendSearch < DatatableArray
  def table_controls(row)
    html = ''

    begin
      objClass = row.self_object_class
      obj = row.self_object
    rescue
      objClass = nil
      obj = nil
    end

    if obj.present?
      html += @view.controller.render_additional_action_buttons obj
      html += table_controls_edit_btn( edit_url(objClass, obj), true ) if obj.editable
      html += table_controls_delete_btn( obj_url(objClass, obj)) if obj.deletable
    end

    html

  end
end