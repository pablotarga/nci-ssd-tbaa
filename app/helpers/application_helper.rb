module ApplicationHelper

  def nav_link(name, path, opts={})
    content_tag :li, link_to(name, path, class: 'nav-link', **opts), class: (request.path == path ? 'nav-item active' : 'nav-item')
  end

end
