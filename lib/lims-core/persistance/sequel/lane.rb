# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistance/lane'
require 'lims/core/persistance/sequel/persistor'

module Lims::Core
  module Persistance
    module Sequel
      # Not a lane but a lane persistor.
      class Lane < Persistance::Lane
        include Sequel::Persistor
        def table_name
          :lanes
        end

        def save(object, flowcell_id, position)
          each do |aliquot|
            aliquot_id = @session.save(aliquot)
            dataset.insert(:flowcell_id => flowcell_id,
                           :position => position,
                           :aliquot_id  => aliquot_id)
          end
        end
      end
    end
  end
end
