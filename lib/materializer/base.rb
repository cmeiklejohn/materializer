# encoding: UTF-8

module Materializer # :nodoc:
  module Base # :nodoc: 

    extend ActiveSupport::Concern

    included do

      # Store all of the materializers.
      #
      cattr_accessor :materializers

      # Trigger materialization on save.
      #
      after_save :materialize!

    end

    module ClassMethods

      # Instruct the class, on save to materialize using a method into a
      # particular attribute.
      #
      def materialize(options)
        self.send(:materializers=, []) if self.send(:materializers).nil?
        self.add_materializer(options)
      end

      # Add a materializer profile.
      #
      def add_materializer(options) # :nodoc:
        materializers = self.send(:materializers)
        materializers << options
        self.send(:materializers=, materializers)
      end

    end

    module InstanceMethods

      # Materialize.
      #
      # after_save hook to create all of the rendered json
      # representations based on materialzation profiles.
      #
      def materialize!
        self.send(:materializers).each do |materializer| 
          using_method   = materializer[:using]
          into_attribute = to_materialized_field_name(materializer[:into])
          generated      = ActiveSupport::JSON.encode(self.send(using_method.to_sym))

          self.send(:update_column, into_attribute, generated)
        end
      end

      # Return content from a materialized profile.
      #
      def from_materialized(options)
        self.send(to_materialized_field_name(options[:profile]))
      end

      # Convert a profile name into the column name where we'll store
      # the data.
      #
      def to_materialized_field_name(name) # :nodoc:
        "#{name}_json"
      end

    end

  end
end
