require 'test_helper'

class SessionTest < ActiveSupport::TestCase

  test "should have an username" do
    session = Session.new
    assert !session.valid?
    assert session.errors.include?(:username)
    
    session = Session.new(:username => "natsume")
    session.valid?
    assert !session.errors.include?(:username)
  end

  test "should have a password" do
    session = Session.new
    assert !session.valid?
    assert session.errors.include?(:password)
    
    session = Session.new(:password => "natsumes_password")
    session.valid?
    assert !session.errors.include?(:password)
  end
  
  test "should return a real user for the username" do
    User.expects(:find_by_username).with("natsume")
    
    session = Session.new(:username => "natsume")
    session.user
  end
  
  test "should validate against the UsernamePasswordValidator" do
    session = Session.new
    UsernamePasswordValidator.any_instance.expects(:validate).with(session)
    session.valid?
  end
  
  test "should include ActiveModel::Validations" do
    assert_kind_of ActiveModel::Validations, Session.new
  end
  
  test "should extend ActiveModel::Naming" do
    assert_kind_of ActiveModel::Naming, Session
  end

end
