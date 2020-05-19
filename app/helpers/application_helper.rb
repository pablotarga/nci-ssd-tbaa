module ApplicationHelper

  def nav_link(name, path, opts={})
    link_class = ['nav-link']
    link_class << [opts.delete(:class)] if opts.key? :class
    link = link_to(name, path, class: link_class.join(' '), **opts)

    spaced = opts.delete(:spaced)
    li_class = ['nav-item']
    li_class << 'active' if is_current_path?(path)
    li_class << 'ml-md-auto' if spaced

    content_tag :li, link, class: li_class.join(' ')
  end

  def can_create_project?
    current_user.try(:advisor?) || current_user.try(:admin?)
  end

  def can_edit_project?
    current_user.try(:advisor?) || current_user.try(:admin?)
  end

  def is_current_path?(path)
    request_controller, _ = recognize_path(request.path)
    query_controller, _ = recognize_path(path)

    request_controller == query_controller
  end

  def recognize_path(path)
    @recognized_paths ||= {}
    @recognized_paths[path] ||= (Rails.application.routes.recognize_path(path) rescue {}).values_at(:controller, :action)
    @recognized_paths[path]
  end

  def project_prog_bar(project)
    content_tag(:div, class: "progress project-#{project.id}-progress") do
      content_tag(:div, nil,
        class: 'progress-bar progress-bar-striped progress-bar-animated bg-info',
        role: 'progressbar',
        aria: {valuenow: project.completion_percentage, valuemin: 0, valuemax: 100},
        style: "width: #{project.completion_percentage}%"
      )
    end
  end

  def project_prog_label(project)
    content_tag(:span, "#{project.completion_percentage}%", class: "project-#{project.id}-progress-label")
  end


end
