# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistence/persistor'


module Lims::Core
  module Persistence
    module Composite
      # Specific implementation of a composite Persistor
      module Persistor
        def initialize(session, name, *args, &block)
          @persistors=[session.main_session, *session.secondary_sessions].map { |s| s.persistor_for(name) }
          @main_persistor = @persistors.shift
          super(session, name, *args, &block)
        end

        # redefine raw write methods to broacasts to every persistors
        %w(save_new update).each do |m|
          define_method( m) do | *args, &block|
          @main_persistor.send(m, *args, &block).tap {
            @persistors.each { |p| p.send(m, *args, &block) }
          }
          end

          # delegate raw load methods to the main persistor.
          %w(load_raw_object load_children).each do |m|
            define_method(m) do | *args, &block|
              @main_persistor.send(m, *args, &block)
            end
          end
        end
      end
    end
  end
end
