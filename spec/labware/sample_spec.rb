# Spec requirements
require 'labware/spec_helper'
require 'data_release/releasable_examples'

# Model requirements
require 'lims/core/labware/sample'

module Lims::Core::Labware
  describe Sample do
    it_behaves_like "releasable"
  end
end

