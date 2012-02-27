# vi: ts=2:sts=2:et:sw=2

require 'forwardable'


module Lims::Core
    module  Persistance
      # A session is in charge of restoring and saving object throug the persistance layer.
      # A Session can not normally be created by the end user. It has to be in a Store::with_session
      # block, which acts has a transaction and save/update everything at the end of it.
      # It should also provides an identity map.
      # Session information (user, time) are also associated to the modifications of those objects.
      class Session
        extend Forwardable
        # param [Store] store the underlying store.
        def initialize(store)
          @store = store
          @objects = Set.new
          @in_session = false
          @saved = Set.new
        end

        def_delegators :@store, :database

        # Execute a block and save every 'marked' object
        # in a transaction at the end.
        # @yieldparam [Session] session the created session.
        # @return the value of the block
        def with_session(*params, &block)
          @in_session = true
          to_return = block[self]
          @in_session = false
          save_all
          return to_return
        end


        # Tell the session to be responsible of an object.
        # The object will be saved at the end of the session.
        # @example
        #   store.with_session do |session|
        #     session << Plate.new
        #   end
        # @param [Persistable] object the object to persist.
        # @return  the object itself.
        def << (object)
          @objects << object
        end

        private
        # save the object in real.
        # To mark un object as 'to save' use the `<<` method
        # @return [Boolean]
        def save(object)
          return if @saved.include?(object)
          @saved << object

          persistor_for(object).save(object)
        end

        # save all objects which needs to be
        def save_all()
          @objects.each do |object|
            save(object)
          end
        end

        def persistor_for(object)
          name = object.class.name.split('::').pop
          send(name.underscore)
        end
      end
    end
end

