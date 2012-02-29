# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en



module Lims::Core
  module Persistance
    module Sequel
      # Mixin giving persistor (load/save) behavior.
      # The base class, needs to implements a `self.model`
      # returning the class to persist.
      # Each instance can get an identity map, and or parameter
      # specific to a session/thread.
      module Persistor
        def self.included(klass)
          klass.class_eval do
            # @return [String] the name of SQL table.
            def table_name
              raise NotImplementedError
            end
            # The Sequel::Dataset.
            # Corresponds to table.
            # @param [Sequel::Session] session 
            # @return [::Sequel::Dataset]
            def self.dataset(session)
              session.database[self.table_name]
            end
          end
        end

        def initialize (session, *args, &block)
          @session = session
          super(*args, &block)
        end

        # Associate class (without persistance).
        # @return [Class]
        def model
          self.class::Model
        end


        def table_name
          self.class.table_name
        end


        # The Sequel::Dataset.
        # Corresponds to a table.
        # @return [::Sequel::Dataset]
        def dataset
          self.class.dataset(@session)
        end

        # save an object and return is id or nil if failure
        # @return [Boolean, Nil]
        def save(object, *params)
          dataset.insert(object.attributes).tap do |id|
            save_children(id, object)
          end
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

        # Load a model object (and its children) from its database id.
        # @param id id in the database
        # @return [Object] the model object.
        # @raises error if object doesn't exists.
        def load_single_model(id)
          model.new(dataset[:id => id]).tap do |m|
            load_children(id, m)
          end
        end

        # Loads children from the database and set the to model object.
        # @param id primary key of the model object in the database.
        # @param m  instance of model to load
        # @return
        def load_children(id, m)
        end

      end
    end
  end
end
