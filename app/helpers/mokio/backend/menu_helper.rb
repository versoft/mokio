module Mokio
  module Backend
    module MenuHelper
      include Haml::Helpers
      
      #displays breadcrump to current menu element
      def tree_menu_breadcrumps(menu)
        unless menu.nil?
          @tree_nodes = menu.ancestors << menu
          @tree_nodes.map do |m|
            if m.present? and m != menu
              link_to(m.name, edit_menu_path(m)) + " -> "
            elsif m.present? and m == menu
              link_to(m.name, edit_menu_path(m)) unless m.id.nil?
            end
          end.join.html_safe
        end
      end

      #dispays drag & drop tree for menus
      def tree_menu(menus, sortable)
        menus.map do |menu, sub_menu|
            content_tag :li, :id => dom_id(menu), :class => "sortable_#{sortable}" do
              render(menu) + (content_tag(:ol, tree_menu(sub_menu, true)) if sub_menu.present?)
            end
        end.join.html_safe
      end

      #
      # html for dual select box
      #
      def dual_select_box(col_left, left_id, left_name, col_right, right_id, right_name, label, html_id, field, useFilters, showColTitle, always, editable)
        html = dual_select_open(label, html_id, useFilters)              
        html << dual_select_left_box(html_id, col_left, editable, left_name, left_id)

        if editable
          html << dual_select_buttons(html_id, useFilters)
          html << dual_select_right_box(html_id, useFilters, editable, col_right, right_id, right_name, always, field)
        end

        html << dual_select_close
        html.html_safe
      end

      def dual_select_open(label, html_id, useFilters)
        "<div class='row-fluid'><label class='form-label span2'>#{label}</label><div class='panel-body span10'><div class='form-group'>#{dual_select_search_box(html_id) if useFilters}<div class='col-lg-12'>"
      end

      def dual_select_close
        "</div></div></div></div>"
      end

      def dual_select_search_box(html_id)
        "<div class='searchBox'><input id='box1Filter#{html_id}' class='searchField form-control' placeholder='#{t("menus.filter")}' type='text'></input></div>"
      end

      def dual_select_buttons(html_id, useFilters)
        "<div id='#{useFilters ? 'button-group-filter' : 'button-group'}' class='dualBtn'>
          <div class='container_btn'>
            <button id='to2#{html_id}' class='btn' type='button'><span class='icon12 minia-icon-arrow-right-3'></span></button>
            <button id='allTo2#{html_id}' class='btn' type='button'><span class='icon12 iconic-icon-last'></span></button>
            <button id='to1real#{html_id}' class='btn marginT5' type='button'><span class='icon12 minia-icon-arrow-left-3'></span></button>
            <button id='to1#{html_id}' class='btn marginT5 fake' type='button'></button>
            <button id='allTo1#{html_id}' class='btn marginT5 fake' type='button'></button>
            <button id='allTo1real#{html_id}' class='btn marginT5' type='button'><span class='icon12 iconic-icon-first'></span></button>
          </div>
        </div>"
      end

      def dual_select_left_box(html_id, col_left, editable, left_name, left_id)
        "<div class='leftBox'>
          #{select_tag(:all_articles, options_for_select(col_left.collect{|elt| [elt.send(left_name), elt.send(left_id),{class: "displayed_#{elt.displayed?}"}]}), multiple: true, class: 'multiple nostyle form-control select-box', id: 'box1View' + html_id, disabled: !editable)}
          <span id='box1Counter#{html_id}' class='count fake'></span>
          <div class='dn'>
            <select id='box1Storage#{html_id}' class='nostyle' name='box1Storage'></select>
          </div>
        </div>"
      end

      def dual_select_right_box(html_id, useFilters, editable, col_right, right_id, right_name, always, field)
        html = "<div class='rightBox'>"
        html << dual_select_right_box_search(html_id) if useFilters
        html << "#{select_tag(field, options_from_collection_for_select(col_right, right_id, right_name), multiple: true, class: 'multiple nostyle form-control sortableSelect fake', id: 'box2View' + html_id, disabled: !editable)}"
        html << "<div class='list-wrapper'><ul id='fake-select#{html_id}' class='ui-sortable fake-select'>"

        col_right.each do |elt|
          always_class = ""
          always_class = "always_#{elt.static_module.always_displayed}" if always
          lang_all_class = ""
          lang_all_class = "all_lang" if elt.lang_id.nil?

          html << "<li class='displayed_#{elt.displayed?} #{always_class} #{lang_all_class}' id='art#{html_id}_#{elt.send(right_id)}'>#{elt.send("#{right_name}".to_sym)}</li>"
        end

        html << "</ul><span id='box2Counter#{html_id}' class='count fake'></span>"
        html << "<div class='dn'><select id='box2Storage#{html_id}' class='nostyle fake' name='box2Storage'></select></div></div></div>"
      end

      def dual_select_right_box_search(html_id)
        "<div class='searchBox'>
          <input id='livefilter-input#{html_id}' class='searchField form-control fake' placeholder='filter ...' type='text'></input>
          <input id='box2Filter#{html_id}' class='searchField form-control fake' placeholder='filter ...' type='text'></input>
        </div>"
      end



      # #generates haml for dual select box

      # def dual_select_box (col_left, left_id, left_name, col_right, right_id, right_name, label, html_id, field, useFilters, showColTitle, always, editable)
      #   capture_haml do
      #     haml_tag :div, :class => 'row-fluid' do
      #       haml_tag :label, label, :class => "form-label span2"
      #       haml_tag :div, :class => 'panel-body span10' do
      #         haml_tag :div, :class => 'form-group' do
      #           if useFilters
      #             haml_tag :div, :class => 'searchBox' do
      #               haml_tag :input, :id => 'box1Filter' + html_id, :class => 'searchField form-control', :placeholder => "filter ...", :type => 'text'
      #             end 
      #           end
      #           haml_tag :div, :class => 'col-lg-12' do
      #             haml_tag :div, :class => 'leftBox' do
      #               haml_concat(select_tag(:all_articles, options_for_select(col_left.collect{|elt| [elt.send(left_name), elt.send(left_id),{class: "displayed_#{elt.displayed?}"}]}), multiple: true, class: 'multiple nostyle form-control select-box', id: 'box1View'  + html_id, disabled: !editable))
      #               haml_tag :span, :id => 'box1Counter' + html_id, :class => 'count fake'
      #               haml_tag :div, :class => 'dn' do
      #                 haml_tag :select, :id => 'box1Storage' + html_id, :class => 'nostyle', :name => "box1Storage"
      #               end
      #             end
      #             if editable
      #               haml_tag :div, :class => 'dualBtn', :id => useFilters ? 'button-group-filter' : 'button-group'  do
      #                 haml_tag :div, :class => "container_btn" do
      #                   haml_tag :button, :id => 'to2' + html_id, :class => 'btn', :type => 'button' do
      #                     haml_tag :span, :class => 'icon12 minia-icon-arrow-right-3'
      #                   end
      #                   haml_tag :button, :id => 'allTo2' + html_id, :class => 'btn', :type => 'button' do
      #                     haml_tag :span, :class => 'icon12 iconic-icon-last'
      #                   end
      #                   haml_tag :button, :id => 'to1real' + html_id, :class => 'btn marginT5', :type => 'button' do
      #                     haml_tag :span, :class => 'icon12 minia-icon-arrow-left-3'
      #                   end
      #                   haml_tag :button, :id => 'to1' + html_id, :class => 'btn marginT5 fake', :type => 'button' 
      #                   haml_tag :button, :id => 'allTo1' + html_id, :class => 'btn marginT5 fake', :type => 'button'
      #                   haml_tag :button, :id => 'allTo1real' + html_id, :class => 'btn marginT5', :type => 'button' do
      #                     haml_tag :span, :class => 'icon12 iconic-icon-first'
      #                   end
      #                 end
      #               end
      #               haml_tag :div, :class => 'rightBox' do
      #                 if useFilters
      #                   haml_tag :div, :class => 'searchBox' do
      #                     haml_tag :input, :id => 'livefilter-input' + html_id, :class => 'searchField form-control fake', :placeholder => "filter ...", :type => 'text'
      #                     haml_tag :input, :id => 'box2Filter' + html_id, :class => 'searchField form-control fake', :placeholder => "filter ...", :type => 'text'
      #                   end 
      #                 end
      #                 haml_concat(select_tag(field, options_from_collection_for_select(col_right, right_id, right_name), multiple: true, class: 'multiple nostyle form-control sortableSelect fake', id: 'box2View' + html_id, disabled: !editable))
      #                 haml_tag :div, :class => 'list-wrapper' do
      #                   haml_tag :ul, :id => 'fake-select' + html_id, :class => 'ui-sortable fake-select' do
      #                     col_right.each do |elt|
      #                       always_class = ""
      #                       always_class = "always_#{elt.static_module.always_displayed}" if always
      #                       lang_all_class = ""
      #                       lang_all_class = "all_lang" if elt.lang_id.nil?
      #                       haml_tag :li, :class=> "displayed_#{elt.displayed?} #{always_class} #{lang_all_class}", :id => "art#{html_id}_#{elt.send(right_id)}" do
      #                         haml_concat(elt.send("#{right_name}".to_sym))
      #                       end
      #                     end
      #                   end
      #                   haml_tag :span, :id => 'box2Counter' + html_id, :class => 'count fake'
      #                   haml_tag :div, :class => 'dn' do
      #                     haml_tag :select, :id => 'box2Storage' + html_id, :class => 'nostyle fake', :name => "box2Storage"
      #                   end
      #                 end
      #               end
      #             end
      #           end
      #         end  
      #       end
      #     end   #panel-body
      #   end
      # end   #def dual_select_box

      #generates code that replaces available modules after lang change

      def replace_available_modules(menu)
        str = ""
        ModulePosition.all.each do |mp|
          if !menu.available_modules_by_pos[mp.id].nil?
            str += "$('#box1View_" + mp.id.to_s + "').html('" +  ( j(options_for_select(menu.available_modules_by_pos[mp.id].collect{|elt| [elt.module_title, elt.id, {class: 'displayed_' + elt.displayed?.to_s}]}))) + "');"
          else 
            str += "$('#box1View_" + mp.id.to_s + "').html('');"
          end
        end
        str.html_safe
      end
    end
  end
end