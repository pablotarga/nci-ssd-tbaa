class ProjectChannel < ApplicationCable::Channel
  def subscribed
    stream_from "projects_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def changeProgress(data)
  end
end
