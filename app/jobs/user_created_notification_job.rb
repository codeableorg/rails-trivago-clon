class UserCreatedNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.where(role: "admin") do |user|
      AdminMailer
        .with(user: user)
        .notify_admin
        .deliver_later
    end
  end
end
