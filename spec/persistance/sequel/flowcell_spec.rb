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
    let(:store) { PS::Store.new(db) }
    before (:each) { prepare_table(db) }

    include_context "flowcell factory"

    def last_flowcell_id(session)
          session.flowcell.dataset.order_by(:id).last[:id]
    end

    context "created and added to session" do
      it "modifies the flowcells table" do
        expect do
          store.with_session { |s| s << new_flowcell_with_samples }
        end.to change { db[:flowcells].count }.by(1)
      end

      it "modifies the lanes table" do
        expect do
          store.with_session { |session| session << new_flowcell_with_samples(3) }
        end.to change { db[:lanes].count }.by(8*3)
      end

      it "should be reloadable" do
        flowcell = store.with_session do |session|
          new_flowcell_with_samples(3).tap do |f|
            session << f
          end
        end
        store.with_session do |session|
          flowcell.should eq(session.flowcell[last_flowcell_id(session)])
        end
      end
    end

    context "created but not added to a session" do
      it "should not be saved" do
        expect do 
          store.with_session { |_| new_flowcell_with_samples(3) }
        end.to change{ db[:flowcells].count }.by(0)
      end 
    end

    context "already created flowcell" do
      let(:aliquot) { new_aliquot }
      before (:each) do
        store.with_session { |session| session << new_empty_flowcell.tap {|_| _[0] << aliquot} }
      end
      let(:flowcell_id) { store.with_session { |session| @flowcell_id = last_flowcell_id(session) } }

      context "when modified" do
        before do
          store.with_session do |s|
            flowcell = s.flowcell[flowcell_id]
            flowcell[0].clear
            flowcell[1]<< aliquot
          end
        end
        it "should be saved" do
          store.with_session do |session|
            debugger
            f = session.flowcell[flowcell_id]
            f[7].should == []
            f[1].should == [aliquot]
            f[0].should == []
            f[0].should be_empty
          end
        end
      end
    end
  end
end
