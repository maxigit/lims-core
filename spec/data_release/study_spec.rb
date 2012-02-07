# Spec requirements
require 'data_release/spec_helper'
require 'data_release/releasable_examples'

# Model requirements
require 'lims/core/data_release/study'

module Lims::Core::DataRelease
  describe Study do
    it_behaves_like "releasable"
  end
end

