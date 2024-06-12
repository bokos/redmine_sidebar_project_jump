module ApplicationHelperPatch
  def self.included(base)
    base.class_eval do
      def render_project_jump_box(project_jump_id='project-jump', project_quick_search_id='projects-quick-search')
       projects = projects_for_jump_box(User.current)
       if @project && @project.persisted?
         text = @project.name_was
       end
       text ||= l(:label_jump_to_a_project)
       url = autocomplete_projects_path(:format => 'js', :jump => current_menu_item)
       trigger = content_tag('span', text, :class => 'drdn-trigger')
       q = text_field_tag('q', '', :id => project_quick_search_id,
                          :class => 'autocomplete',
                          :data => {:automcomplete_url => url},
                          :autocomplete => 'off')
       all = link_to(l(:label_project_all), projects_path(:jump => current_menu_item),
                     :class => (@project.nil? && controller.class.main_menu ? 'selected' : nil))
       content =
         content_tag('div',
                     content_tag('div', q, :class => 'quick-search') +
                       content_tag('div', render_projects_for_jump_box(projects, selected: @project),
                                   :class => 'drdn-items projects selection') +
                       content_tag('div', all, :class => 'drdn-items all-projects selection'),
                     :class => 'drdn-content')
       content_tag('div', trigger + content, :id => project_jump_id, :class => "drdn")
      end
    end
  end
end



module AddDateFormatsWithDayNames
  def self.included(base)
    base.class_eval do
      def date_format_setting_options(locale)
        date_formats = ['%a., %d.%m.%Y', '%A, %d.%m.%Y']
        (Setting::DATE_FORMATS + date_formats).map do |f|
          today = ::I18n.l(User.current.today, :locale => locale, :format => f)
          format = f.delete('%').gsub(/[dmY]/) do
            {'d' => 'dd', 'm' => 'mm', 'Y' => 'yyyy'}[$&]
          end
          ["#{today} (#{format})", f]
        end
      end
    end
  end
end
