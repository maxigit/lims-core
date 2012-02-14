# Spec requirements
require 'labware/spec_helper'
require 'organization/releasable_examples'

# Model requirements
require 'lims/core/labware/sample'

module Lims::Core::Labware
  describe Sample do
    it_behaves_like "releasable"

    context "to be valid" do
      it "requires a name" do
        sample = described_class.new
        sample.valid?.should eq false
      end
    end
  end
end

