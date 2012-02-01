# Spec requirements
require 'labware/spec_helper'
require 'labware/located_examples'
require 'labware/container_examples'
require 'labware/labellable_examples'

# Model requirements
require 'lims/core/labware/flowcell'

module Lims::Core::Labware
  describe Flowcell  do
    it_behaves_like "located" 
    context "contains lanes" do
      it_behaves_like "a container", Lane
    end
    it_behaves_like "labellable"
  end
end
