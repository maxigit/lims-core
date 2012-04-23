# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'logger'
require 'lims/core/persistence/session'

module Lims::Core
  module Persistence
    module Composite
      class Session < Persistence::Session

        attr_reader :sessions, :main_session
        def initialize(store, *params)
          @sessions = store.stores.map { |st|  st.create_session(*params) }
          @main_session = @sessions[0]
          super(store, *params)
        end 

        def secondary_sessions
          sessions.select { |s| s != main_session }
        end

        def with_session(*params, &block)
          super(*params) do |session|
          with_nested_sessions(sessions.clone, *params) do
            block[session]
          end
          end
        end

        def with_nested_sessions(sessions, *params, &block)
          if sessions.empty?
            block.call
          else
            sessions.shift.with_session(*params) do
              with_nested_sessions(sessions, *params, &block)
            end
          end
        end
        private :with_nested_sessions
      end
    end
  end
end
