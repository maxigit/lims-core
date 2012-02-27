# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en



module Lims::Core
  module Persistance
    module Sequel
      # Mixin giving persistor (load/save) behavior.
      # The base class, needs to implements a `self.model`
      # returing the class to persist.
      # Each instance can get an identity map, and or parameter
      # specific to a session/thread.
      module Persistor
        def self.included(klass)
          klass.class_eval do
          end
        end

        #Returns the associate class
        def model
          self.class::Model
        end

        def save
        end

        # Load a model by id
        def [](id)
        end
      end
    end
  end
end
