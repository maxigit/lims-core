# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistance/flowcell'
require 'lims/core/persistance/sequel/persistor'

module Lims::Core
  module Persistance
    module Sequel
      # Not a flowcell but a flowcell persistor.
      class Flowcell < Persistance::Flowcell
        include Sequel::Persistor
        def self.table_name
          :flowcells
        end

        def save_children(id, flowcell)
          flowcell.each_with_index do |lane, position|
            @session.save(lane, id, position)
          end
        end

        def load_children(id, flowcell)
          Lane::dataset(@session).join(Aliquot::dataset(@session), :id => :aliquot_id).filter(:flowcell_id => id).each do |att|
            position = att.delete(:position)
            att.delete(:id)
            aliquot  = Aliquot::Model.new(att)
            flowcell[position] << aliquot
          end
        end
      end
    end
  end
end
