require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should have a first_name and last_name" do
    user = User.new
    assert !user.valid?
    assert user.errors.include?(:first_name)
    assert user.errors.include?(:last_name)
    
    user = User.new(:first_name => "Robin", :last_name => "Nico")
    user.valid?
    assert !user.errors.include?(:first_name)
    assert !user.errors.include?(:last_name)
  end
  
  test "should have an email which actually is an email" do
    user = User.new
    assert !user.valid?
    assert user.errors.include?(:email)
    
    user = User.new(:email => "not_an_email")
    assert !user.valid?
    assert user.errors.include?(:email)
    
    user = User.new(:email => "robin@strawhat-pirates.jp")
    user.valid?
    assert !user.errors.include?(:email)
  end
  
  test "should have an unique username" do
    user = User.new
    assert !user.valid?
    assert user.errors.include?(:username)
    
    user = User.new(
      :username => "robin",
      :email => "robin@strawhat-pirates.jp",
      :first_name => "Robin",
      :last_name => "Nico"
    )
    
    assert user.valid?
    assert user.save
    
    user = User.new(:username => "robin")
    assert !user.valid?
    assert user.errors.include?(:username)
  end
  
  test "should have a real name" do
    user = User.new(:first_name => "Robin", :last_name => "Nico")
    assert_equal "Robin Nico", user.real_name
  end
  
  test "should have username as param" do
    user = User.new(:username => "robin")
    assert_equal "robin", user.to_param
  end
  
  test "should return own messages, mentioned messages and followees messages as all_messages " do
    user = User.new

    user.expects(:id => 42)
    followees = [stub("UserStub", :id => 23)]
    user.expects(:followees).returns(followees)
    
    arel_join_mock = mock("ArelJoinMock")
    arel_join_mock.expects(:order).with("created_at DESC")
    arel_where_mock = mock("ArelWhereMock")
    arel_where_mock.expects(:joins).with(:user => :mentions).returns(arel_join_mock)
    Message.expects(:where).with(:user_id => [23,42]).returns(arel_where_mock)

    user.all_messages
  end
  
  test "should follow other users" do
    robin = User.new(:username => "robin")
    zoro = User.new(:username => "zoro")
    
    followees = mock("Followees")
    followees.expects(:<<).with(zoro)
    robin.expects(:followees).returns(followees)
    
    robin.follow(zoro)
  end
  
  test "should unfollow other users" do
    robin = User.new(:username => "robin")
    zoro = User.new(:username => "zoro")
    
    followees = mock("Followees")
    followees.expects(:delete).with(zoro)
    robin.expects(:followees).returns(followees)
    
    robin.unfollow(zoro)
  end
  
  test "should know who she is following" do
    robin = User.new(:username => "robin")
    zoro = User.new(:username => "zoro")
    
    followees = mock("Followees")
    followees.expects(:find_by_username).with("zoro")
    robin.expects(:followees).returns(followees)
    
    robin.follows?(zoro)
  end
  
end
