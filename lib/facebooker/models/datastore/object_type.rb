module Facebooker
  module Datastore
    class ObjectType
      attr_reader :type, :session
      def initialize(type, session)
        @type, @session = type, session
      end
      
      def set_hash_value(key, property_name, property_value)
        object_id = @session.post(
          'facebook.data.setHashValue', 
          :obj_type => @type.to_s, 
          :key => key.to_s,
          :value => property_value,
          :prop_name => property_name.to_s)
        Facebooker::Datastore::Object.new(self, object_id, @session)
      end
      
      def get_hash_value(key, property_name)
        @session.post(
          'facebook.data.getHashValue',
          :obj_type => @type.to_s,
          :key => key.to_s,
          :prop_name => property_name.to_s)
      end

      def ==(other)
        ObjectType === other        && 
        type       == other.type    &&
        session    == other.session
      end 
    end    
  end
end