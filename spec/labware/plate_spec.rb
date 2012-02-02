# Spec requirements
require 'labware/spec_helper'
require 'labware/located_examples'
require 'labware/container_examples'

# Model requirements
require 'lims/core/labware/plate'

module Lims::Core::Labware
  describe Plate  do
    it_behaves_like "located" 
    context "contains well" do
      it_behaves_like "a container", Well
    end
  end
end
