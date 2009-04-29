module Defv
  module CustomTimestamps
    def self.included(base)
      base.extend         ClassMethods
      base.send :include, InstanceMethods

      base.alias_method_chain :create, :extended_timestamps
      base.alias_method_chain :update, :extended_timestamps
      
      base.class_inheritable_reader :create_column
      base.class_inheritable_reader :update_column
    end

    module ClassMethods
      def set_create_column(create_column)
        write_inheritable_attribute(:create_column, create_column)
      end
      
      def set_update_column(update_column)
        write_inheritable_attribute(:update_column, update_column)
      end
    end

    module InstanceMethods
      def create_with_extended_timestamps
        if record_timestamps
          t = self.class.default_timezone == :utc ? Time.now.utc : Time.now
          
          write_attribute(create_column, t) if create_column && respond_to?(create_column) && send(create_column).nil?
          write_attribute(update_column, t) if update_column && respond_to?(update_column) && send(update_column).nil?
        end
        create_without_extended_timestamps
      end

      def update_with_extended_timestamps(*args) #:nodoc:
        if update_column && record_timestamps && (!partial_updates? || changed?)
          t = self.class.default_timezone == :utc ? Time.now.utc : Time.now

          write_attribute(update_column, t) if respond_to?(update_column)
        end
        update_without_extended_timestamps(*args)
      end
    end
  end
end