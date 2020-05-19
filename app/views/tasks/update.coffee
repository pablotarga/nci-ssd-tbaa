$(".task-row-<%= @task.id %>").replaceWith $("<%= escape_javascript(render partial:'shared/task_row', object: @task)%>")
