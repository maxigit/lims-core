# Spec requirements
require 'chemical/spec_helper'
require 'data_release/releasable_examples'

# Model requirements
require 'lims/core/chemical/sample'

module Lims::Core::Chemical
  describe Sample do
    it_behaves_like "releasable"
  end
end

