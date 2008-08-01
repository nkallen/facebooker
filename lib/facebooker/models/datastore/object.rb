module Facebooker
  module Datastore
    class Object
      attr_reader :object_id, :session
      
      def initialize(object_type, object_id, session)
        @object_type, @object_id, @session = object_type, object_id, session
      end
      
      def update(attributes)
        @session.post(
          'facebook.data.updateObject',
          :obj_id => @object_id.to_i,
          :properties => attributes.to_json,
          :replace => false)
        self
      end
      
      def ==(other)
        Object      === other          &&
        @object_id  == other.object_id &&
        @session    == other.session  
      end
      
      def inspect
        @session.post('facebook.data.getObject', :obj_id => @object_id).inspect
      end
      
      def end
        @object_type
      end
      
      def delete
        @session.post(
          'facebook.data.deleteObject',
          :obj_id => @object_id.to_i)
      end
    end
  end
end