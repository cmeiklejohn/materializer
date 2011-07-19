# encoding: UTF-8

module Materializer # :nodoc:
  module CoreExt # :nodoc: 
    module Array
      extend ActiveSupport::Concern

      module InstanceMethods

        # Return content from a materialized profile.
        #
        def from_materialized(options)
          map do |o|

            # Unfortunately, need to unescape to properly combine it.
            #
            # This is still extremely faster, by an order of 5% or
            # percent faster.
            #
            ActiveSupport::JSON.decode(o.from_materialized(options))

          end
        end

      end
    end
  end
end

Array.send :include, Materializer::CoreExt::Array
