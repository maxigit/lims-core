# vi: ts=2:sts=2:et:sw=2



module Lims::Core
    module  Persistance
      # A session is in charge of restoring and saving object throug the persistance layer.
      # A Session can not normally be created by the end user. It has to be in a Store::with_session
      # block, which acts has a transaction and save/update everything at the end of it.
      # It should also provides an identity map.
      # Session information (user, time) are also associated to the modifications of those objects.
      class Session
        # param [Store] store the underlying store.
        def initialize(store)
          @store = store
        end

        # We don't know yet. Either save in real the object,
        # or mark it as to be saved. Maybe both (depending of session state).
        def save(object)
        end

        # Tell the session to be responsible of an object.
        # The object will be saved at the end of the session.
        # @example
        #   store.with_session do |session|
        #     session << Plate.new
        #   end
        # @param [Persistable] object the object to persist.
        # @return  the objet
        def << (object)
          object
        end

        # save all objects which needs to be
        def save_all()
        end

      end
    end
end

