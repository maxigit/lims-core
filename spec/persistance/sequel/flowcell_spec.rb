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
    before (:all) { prepare_table(@db=::Sequel.sqlite('')) }

    include_context "flowcell factory"

    context "created within a session" do
      let(:store) { PS::Store.new(@db) }

      it "should be savable" do

        flowcell =  flowcell_with_samples(3)
        store.with_session do |session|
          session << flowcell
        end

        store.with_session do |session|
          # Hack to find
          debugger
          flowcell_id = session.flowcell.dataset.order_by(:id).last[:id]

          flowcell.should eq(session.flowcell[flowcell_id])
          flowcell.zip(session.flowcell[flowcell_id]) do |l1, l2|
            l1.size.should eq(l2.size)
            l1.zip(l2) do |a1, a2|
              a1.sample.should eq(a2.sample)
            end
          end
        end

      end
    end
  end
end
