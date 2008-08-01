require File.dirname(__FILE__) + '/../test_helper.rb'
require 'rubygems'
require 'flexmock/test_unit'

class ObjectTest < Test::Unit::TestCase
  
  def setup
    @session = flexmock Facebooker::Session.create('apikey', 'secretkey')
  end
  
  def test_update
    properties = {:twitter_screen_name => 'twttr_user'}
    @session.should_receive(:post).with(
      'facebook.data.updateObject',
      :obj_id => 7, 
      :properties => properties.to_json,
      :replace => false)
    datastore_object = Facebooker::Datastore::Object.new(Object.new, 7, @session)
    datastore_object.update properties
  end
  
  def test_delete
    properties = {:twitter_screen_name => 'twttr_user'}
    @session.should_receive(:post).with(
      'facebook.data.deleteObject',
      :obj_id => 7)
    datastore_object = Facebooker::Datastore::Object.new(Object.new, 7, @session)
    datastore_object.delete
  end
end

