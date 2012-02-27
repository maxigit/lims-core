# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistance/session'
require 'sequel'

require 'lims/core/persistance/sequel/flowcell'

module Lims::Core
  module Persistance
    module Sequel
      # Sequel specific implementation of a {Persistance::Session Session}.
      class Session < Persistance::Session

        def flowcell
          @flowcell ||= @store.base_module::Flowcell.new
        end
      end
    end
  end
end
