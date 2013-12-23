class Broadcast < ActionMailer::Base
  default from: "study.collaborate@gmail.com"

  def broadcast_message(message, to)
    @to = to
    @message = message
    mail to: to, subject: "'DEIS Impact 2014"
  end
end
