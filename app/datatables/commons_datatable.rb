include Haml::Helpers
include Mokio

class CommonsDatatable

  delegate :params,
          :h,
          :edit_url,
          :obj_url,
          :copy_url,
          :table_controls_edit_btn,
          :table_controls_delete_btn,
          :table_controls_copy_btn,
          to: :@view

  def initialize(view, obj_class)
    @view = view
    @obj_class = obj_class

    #setup collection data
    @overwrite_collection = nil
    if @view.controller.respond_to? "current_records"
      @overwrite_collection = @view.controller.current_records
      if !@overwrite_collection.nil?
        @overwrite_collection = @overwrite_collection.page(page).per_page(per_page)
      end
    end
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @obj_class.count,
      iTotalDisplayRecords: collection.total_entries,
      aaData: data
    }
  end

private


  # %tr.odd.gradeA{ :class => ("disabled" if !obj.active) }
  # - @obj_class.columns_for_table.each do |t|
  #   %td{ :id => obj.id }
  #     -#
  #     -# Common index try to find object.attribute_view function in your Model to parse value
  #     -# if it's not defined, just puts simple object.atribute value
  #     -#
  #     - if obj.respond_to?("#{t}_view")
  #       = eval("obj.#{t}_view")
  #     - else
  #       = obj.try(t)
  # %td
  #   .controls.center
  #     = table_controls_edit_btn( edit_url(@obj_class, obj) )
  #     = table_controls_delete_btn( obj_url(@obj_class, obj) ) if obj.deletable
  #     = table_controls_copy_btn( copy_url(@obj_class, obj) ) if obj.deletable
  def data
    collection.map do |row|
      tr_elements = {}
      @obj_class.columns_for_table.map.with_index {|c, index| row.respond_to?("#{c}_view") ? tr_elements[index] = eval("row.#{c}_view") : tr_elements[index] = row.try(c) }
      tr_elements[@obj_class.columns_for_table.size] = table_controls( row )
      tr_elements["DT_RowId"] = row.id
      tr_elements
    end
  end

  def table_controls( row )
    html = ""
    html += @view.controller.render_additional_action_buttons row
    html += table_controls_edit_btn( edit_url(@obj_class, row), true ) if row.editable
    html += table_controls_copy_btn( copy_url(@obj_class, row) ) if row_cloneable? row
    html += table_controls_delete_btn( obj_url(@obj_class, row)) if row.deletable
    html
  end

  def row_cloneable?(row)
    (row.respond_to? "cloneable?") ? row.cloneable? : true
  end

  def collection
    @collection ||= fetch_commons
  end

  def fetch_commons
    if @overwrite_collection.nil?
      start_collection = @obj_class
    else
      start_collection = @overwrite_collection
    end

    if params[:sSearch].present?
      # TODO Check Solr Server Running
      if Mokio.solr_enabled
        searched =  Sunspot.search @obj_class do
          fulltext params[:sSearch]
          paginate page: page, per_page: per_page
        end
        collection = searched.results
      else
        columns = ''
        first_col = true
        @obj_class.columns.each do |c|
          next unless can_use_column_to_search? c
          columns << " OR " unless first_col
          columns << c.name
          columns << ' LIKE :kw'
          first_col = false
        end
        collection = start_collection.order("#{sort_column} #{sort_direction}").where("#{columns}",:kw=>"%#{params[:sSearch]}%")
        collection = collection.page(page).per_page(per_page)
      end

    elsif params[:only_loose].present?
      collection = start_collection.includes(:menus).where(:mokio_content_links => {:content_id => nil}).order("#{sort_column} #{sort_direction}")
      collection = collection.page(page).per_page(per_page)
    else
      collection = start_collection.order("#{sort_column} #{sort_direction}")
      collection = collection.page(page).per_page(per_page)
    end
    collection
  end

  def can_use_column_to_search?(column)
    type_check = [:string, :text].include? column.type
    allowed_search = true
    if @obj_class.respond_to? :allowed_search_columns
      allowed_search = @obj_class.allowed_search_columns.include? column.name
    end
    type_check && allowed_search
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : Mokio.backend_default_per_page
  end

  def sort_column
    param_column = @obj_class.columns_for_table[params[:iSortCol_0].to_i]
    column_name = nil
    if @obj_class.respond_to? :override_column_sort
      column_name = @obj_class.override_column_sort[param_column.to_sym]
    end
    column_name ? column_name : param_column
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end