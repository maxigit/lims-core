# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistance/flowcell'
require 'lims/core/persistance/sequel/persistor'

module Lims::Core
  module Persistance
    module Sequel
      # Not a flowcell but a flowcell persistor.
      class Flowcell < Persistance::Flowcell
        include Sequel::Persistor
        def table_name
          :flowcells
        end
      end
    end
  end
end
