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
        flowcell_id = store.with_session do |session|
          session << flowcell
        end

        store.with_session do |session|
          session.flowcell[flowcell_id].should be === flowcell
        end

      end
    end
  end
end
