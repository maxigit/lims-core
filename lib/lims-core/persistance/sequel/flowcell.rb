# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims/core/persistance/flowcell'
require 'lims/core/persistance/sequel/persistor'

module Lims::Core
  module Persistance
    module Sequel
      # Not a flowcell but a flowcell persistor.
      class Flowcell < Persistance::Flowcell
        include Sequel::Persistor

      # Not a lane but a lane {Persistor}.
        class Lane < Persistance::Flowcell::Lane
          include Sequel::Persistor
          def self.table_name
            :lanes
          end

          def save(lane, flowcell_id, position)
            #todo bulk save if needed
            lane.each do |aliquot|
              aliquot_id = @session.save(aliquot)
              dataset.insert(:flowcell_id => flowcell_id,
                             :position => position,
                             :aliquot_id  => aliquot_id)
            end
          end
        end #class Lane

        def self.table_name
          :flowcells
        end

        # Save all children of the given flowcell
        # @param [Fixnum] id the id in the database
        # @param [Labware::Flowcell] flowcell
        # @return [Boolean]
        def save_children(id, flowcell)
          flowcell.each_with_index do |lane, position|
            @session.save(lane, id, position)
          end
        end

        # Delete all children of the given flowcell
        # But don't destroy the 'external' elements (example aliquots)
        # @param [Fixnum] id the id in the database
        # @param [Labware::Flowcell] flowcell
        def delete_children(id, flowcell)
          Lane::dataset(@session).filter(:flowcell_id => id).delete
        end

        # Load all children of the given flowcell
        # Loaded object are automatically added to the session.
        # @param [Fixnum] id the id in the database
        # @param [Labware::Flowcell] flowcell
        # @return [Labware::Flowcell, nil] 
        #
        def load_children(id, flowcell)
          Lane::dataset(@session).join(Aliquot::dataset(@session), :id => :aliquot_id).filter(:flowcell_id => id).each do |att|
            position = att.delete(:position)
            att.delete(:id)
            aliquot  = @session.aliquot[:aliquot_id] || Aliquot::Model.new(att)
            flowcell[position] << aliquot
          end
        end
      end
    end
  end
end
