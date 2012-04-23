# Spec requirements
require 'persistence/composite/spec_helper'

require 'laboratory/plate_shared'
require 'persistence/sequel/store_shared'

# Model requirements
require 'lims/core/persistence/composite/store' 
require 'lims/core/persistence/sequel/store'
require 'lims/core/persistence/logger/store'

# We use real object here (ie Store and Plate ) to really the final thing.
# Trying to use mock end up in stubing too much, meaning the actual test might
# be biased by the stubs.

module Lims::Core::Persistence
  describe Composite::Store do
    context "in a Sequel environment" do
      before (:each) { prepare_table(db) }
      include_context "prepare tables"
      let(:db) { ::Sequel.sqlite('') }
      include_context 'plate factory'
      let(:row_number) { 7 }
      let(:column_number) { 5 }
      let (:sample_number)  { 3} 
      let(:plate) { new_plate_with_samples(sample_number) }

      context "set with 2 underlying stores" do
        let(:store1) { Sequel::Store.new(db) }
      let (:logger) { ::Logger.new($stdout) }
        let(:store2) { Logger::Store.new(logger) }
        subject { described_class.new(store1, store2) }

        context "#creating a new plate" do
          def create_new_plate
            plate_id = subject.with_session do |session|
              session << plate
              lambda { session.id_for(plate) }
            end.call 
          end

          it "should save it and reload it" do
            plate_id = create_new_plate

            subject.with_session do |session|
              session.plate[plate_id].should == plate
            end
          end

          it "should log the plate" do

        logger.should_receive(:send).with(:info, 'Lims::Core::Laboratory::Plate: {:row_number=>7, :column_number=>5}')
        logger.should_receive(:send).exactly(row_number*column_number*sample_number)
            plate_id = create_new_plate

          end
        end
      end
    end
  end
end


