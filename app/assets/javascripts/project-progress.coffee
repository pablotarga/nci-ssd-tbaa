$(document).on 'turbolinks:load', =>
  $('body')
    .on 'app.updateProjectProgress', (e, project) =>
      $(".project-#{project.id}-progress")
        .find '.progress-bar'
        .attr 'aria-valuenow', project.completion_percentage
        .css 'width', "#{project.completion_percentage}%"

      $(".project-#{project.id}-progress-label")
        .text "#{project.completion_percentage}%"
