# vi: ts=2:sts=2:et:sw=2



module Lims::Core
    module  Persistance
      # A store represents a persistant datastore, where object can be saved and restored.
      # A connection to a database, for example.
      class Store
        # Create a session and pass it to the block.
        # This is the only way to get a session.
        # @param  Array
        # @yieldparam [Session] session the created session.
        def with_session(*params, &block)
          session = create_session(self, *params)
          yield(session)
          session.save_all
        end
      end
    end
end

