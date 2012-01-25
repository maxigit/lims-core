module Lims::Core
  module Labware
    # @todo doc
    module Container
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
      # Declare the container using the contained classes
      # Define basic iterators
      # @macro [new] contains
      #   Has many $1.
      # @todo implement
      def contains(klass)
      end
      end
    end
  end
end
