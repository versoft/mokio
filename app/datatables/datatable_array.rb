include Haml::Helpers
include Mokio
require 'will_paginate/array'

class DatatableArray < CommonsDatatable
  def initialize(view,obj_class,array_collection =  nil)
    @view = view
    @obj_class = obj_class
    @array_collection = array_collection
  end

  def as_json(options = {})
    array_collection = @array_collection || []
    total_entries = (array_collection.count > 0 ) ? array_collection.count : 1
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: array_collection.count,
      iTotalDisplayRecords: total_entries,
      aaData: data
    }
  end

  def table_controls(row)
    return
  end

  def row_cloneable?
    false
  end

  def collection
    @collection = []

    if @view.controller.respond_to?("current_records_array")
      @collection = @view.controller.current_records_array

      if @collection.present?
        @collection = @collection.sort_by! {|o| o.send("#{sort_column}")}

        if sort_direction == "desc"
          @collection = @collection.reverse
        end

        @collection = @collection.paginate(:page => page, :per_page => per_page)
      end
    end
    @collection
  end
end