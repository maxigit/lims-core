# Spec requirements
require 'persistence/sequel/spec_helper'

require 'persistence/sequel/store_shared'

# Model requirements
require 'lims/core/persistence/sequel/store'

module Lims::Core
  module Organization
    describe Order  do
      include_context "sequel store"

      def self.load_order(order_id)
        store.with_session do |order|
          yield( session.orders[order_id])
        end
      end


      context "an empty order" do
        it "can be saved" do
          save(subject).should_not be_nill
        end

        context "being saved" do
          it "modifies the orders table" do
            expect { save(subject) }.to change { db[:orders].count }.by(1)
          end

        end

      end
      context "an order with items" do
        let(:source) { Item.new }
        subject { Order.new(:items => { :source => source} ) }
        it "modifies the items table" do
          expect { save(subject) }.to change { db[:items].count }.by(1)
        end

        context "saved" do
          let!(:order_id) { save(subject) }
          let(:source2) { mock(:source2) }

          it "can be reloaded" do
            store.with_session do |session|

              loaded = session.orders[order_id]
              # testing object is well loaded
              loaded.should == subject

              # testing items are well loaded
              loaded[:source].should == subject[:source]
            end
          end

          it "can have empty items added" do
            load_order(order_id) do |order|
              order.add_target(:intermediate_target)
            end
            load_order(order_id) do |order|
              order[:intermediate_target].should be_an(Item)
              order[:intermediate_target].status.should == "pending"
            end
          end


          it "can have non-empty items added" do
            load_order(order_id) do |order|
              order.add_source(:source2, source2)
            end

            load_order(order_id) do |order|
              order[:source2].should == source2
            end

          end

          let(:state) { {:my_state => 34 } }
          it "can it's state updated" do
            load_order(order_id) do |order|
              order.state = state
            end

            load_order(order_id) do |order|
              order.state.should == state
            end
          end

          context "with an intermediate item" do
            subject { Order.new.tap { |o| o.add_target(:intermediate_target) } }
            it "can have item's state updated" do
              load_order(order_id) do |order|
                order[:intermediate_target].start
              end
              load_order(order_id) do |order|
                order[:intermediate_target].status.should == "in_progress"
              end
            end
          end
          context "with an intermediate item in progress"  do
            let(:item_uuid) { "uuid" }
            subject do Order.new.tap do |o|
              o.add_target(:intermediate_target);  
              o[:intermediate_target].start
            end
            end
            it "can have item's uuid updated" do
              load_order(order_id) do |order|
                order[:intermediate_target].uuid =  uuid
              end
              load_order(order_id) do |order|
                order[:intermediate_target].uuid.should == uuid
              end
            end
          end

          it "can be failed" do
            load_order(order_id) do |order|
              order.fail
            end
            load_order(order_id) do |order|
              order.failed?.should == true
            end
          end
        end
      end
    end
  end
end