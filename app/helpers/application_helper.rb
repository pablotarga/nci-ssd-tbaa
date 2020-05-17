module ApplicationHelper

  def nav_link(name, path, opts={})
    link_class = ['nav-link']
    link_class << [opts.delete(:class)] if opts.key? :class
    link = link_to(name, path, class: link_class.join(' '), **opts)

    spaced = opts.delete(:spaced)
    li_class = ['nav-item']
    li_class << 'active' if request.path == path
    li_class << 'ml-auto' if spaced

    content_tag :li, link, class: li_class.join(' ')
  end

end
