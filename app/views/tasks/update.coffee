$(".task-row-<%= @task.id %>").replaceWith $("<%= escape_javascript(render partial:'shared/task_row', object: @task)%>")

$('body').trigger 'app.updateProjectProgress', {id: <%= @task.project.id %>, completion_percentage: <%= @task.project.completion_percentage%>}
