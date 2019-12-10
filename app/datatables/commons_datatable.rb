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
    if @view.controller.respond_to? "current_records"
      @collection = @view.controller.current_records
      @collection = @collection.page(page).per_page(per_page) if !@collection.nil?
    end
    @collection ||= fetch_commons
  end

  def fetch_commons

    if params[:search].present? && params[:search][:value].present?
      # TODO Check Solr Server Running
      if Mokio.solr_enabled
        searched =  Sunspot.search @obj_class do
          fulltext params[:search][:value]
          paginate page: page, per_page: per_page
        end
        collection = searched.results
      else
        columns = ''
        first_col = true
        @obj_class.columns.each do |c|
          next unless [:string, :text].include? c.type
          columns << " OR " unless first_col
          columns << c.name
          columns << ' LIKE :kw'
          first_col = false
        end
        collection = @obj_class
          .order("#{sort_column} #{sort_direction}")
          .where("#{columns}", :kw=>"%#{params[:search][:value]}%")
        collection = collection.page(page).per_page(per_page)
      end

    elsif params[:only_loose].present?
      collection = @obj_class
        .includes(:menus)
        .where(:mokio_content_links => {:content_id => nil})
        .order("#{sort_column} #{sort_direction}")
      collection = collection.page(page).per_page(per_page)
    else
      collection = @obj_class.order("#{sort_column} #{sort_direction}")
      collection = collection.page(page).per_page(per_page)
    end
    collection
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : Mokio.backend_default_per_page
  end

  def sort_column
    param_column = @obj_class.columns_for_table[sort_column_index]
    column_name = nil
    if @obj_class.respond_to? :override_column_sort
      column_name = @obj_class.override_column_sort[param_column.to_sym]
    end
    column_name ? column_name : param_column
  end

  def sort_column_index
    sort_data[:column]
  end

  def sort_direction
    sort_data[:direction]
  end

  def sort_data
    if params[:order]
      if params[:order]["0"]
        index = params[:order]["0"]["column"].to_i
        dir = params[:order]["0"]["dir"]
        return {column: index, direction: dir}
      end
    end
    return {column: 0, direction: "asc"}
  end
end
