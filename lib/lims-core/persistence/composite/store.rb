# vi: ts=2:sts=2:et:sw=2

require 'lims/core/persistence'
require 'lims/core/persistence/store'

module Lims::Core
  module Persistence
    module Composite
        # Create a 'composite' store ie a set of stores.
        # Saving a object to a composite store save it to all stores,
        # whereas loading  an object loads only from the first available store.
      class Store < Persistence::Store
        attr_reader :stores
        # Create a composite store
        # @param [Store] store ... a store to compose the composite.
        def initialize(*args)
          @stores, args = args.partition { |s| s.is_a?(Persistence::Store) }
          super(*args)
        end
      end
    end
    finalize_submodule(Composite)
  end
end
