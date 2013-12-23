require 'test_helper'

class BroadcastTest < ActionMailer::TestCase
  test "broadcast_message" do
    mail = Broadcast.broadcast_message
    assert_equal "Broadcast message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
