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

        def initialize (session, *args, &block)
          @session = session
          super(*args, &block)
        end
        #Returns the associate class
        def model
          self.class::Model
        end

        def dataset
          @session.database[model]
        end

        # save an object and return is id or nil if failure
        # @return [Boolean, Nil]
        def save(object, *params)
          id = dataset.insert(object.attributes)
          save_children(id, object)
        end
        def save_children(id, object)
        end

        # Load a model by id
        def [](id)
          case id
          when Fixnum
            load_single_model(id)
          end
        end

        def load_single_model(id)
          model.new(dataset[:id => id]).tap do |m|
            load_children(id, m)
          end
        end

        def load_children(id, m)
        end
      end
    end
  end
end
