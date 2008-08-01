require File.dirname(__FILE__) + '/../test_helper.rb'
require 'rubygems'
require 'flexmock/test_unit'

class ObjectTypeTest < Test::Unit::TestCase
  
  def setup
    @session = flexmock Facebooker::Session.create('apikey', 'secretkey')
  end
  
  def test_set_hash_value
    @session.should_receive(:post).with(
      'facebook.data.setHashValue',
      :obj_type => 'object_type_name', 
      :key => 'sam', 
      :value => 12345, 
      :prop_name => 'facebook_id_property'
    ).and_return(id = 1)
    object_type = Facebooker::Datastore::ObjectType.new('object_type_name', @session)
    assert_equal Facebooker::Datastore::Object.new(object_type, id, @session),
      object_type.set_hash_value('sam', :facebook_id_property, 12345)
  end
  
  def test_get_hash_value
    @session.should_receive(:post).with(
      'facebook.data.getHashValue',
      :obj_type => 'object_type_name', 
      :key => 'sam', 
      :prop_name => 'facebook_id_property'
    ).and_return(value = 12345)
    object_type = Facebooker::Datastore::ObjectType.new('object_type_name', @session)
    assert_equal value, object_type.get_hash_value('sam', :facebook_id_property)
  end
  
end