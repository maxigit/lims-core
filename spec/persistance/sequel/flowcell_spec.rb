# Spec requirements
require 'persistance/sequel/spec_helper'

require 'labware/flowcell_shared'
require 'persistance/sequel/store_shared'

# Model requirements
require 'lims/core/persistance/sequel/store'
require 'lims/core/labware/flowcell'

PS=Lims::Core::Persistance::Sequel
module Lims::Core
  describe Labware::Flowcell do
    include_context "prepare tables"
    let(:db) { ::Sequel.sqlite('') }
    before (:each) { prepare_table(db) }

    include_context "flowcell factory"

    context "created within a session" do
      let(:store) { PS::Store.new(db) }
      let(:flowcell) do
        store.with_session do |session|
          flowcell_with_samples(3).tap do |f|
            session << f
          end
        end
      end
      before(:each) { flowcell }

      it "should be savable" do
        store.with_session do |session|
          # Hack to find last id
          flowcell_id = session.flowcell.dataset.order_by(:id).last[:id]

          flowcell.should eq(session.flowcell[flowcell_id])
        end
      end
    end
  end
end
