# Spec requirements
require 'labware/spec_helper'

module Lims::Core::Labware
  # A Container contains 'contained' 
  module Container
  end
end
shared_examples "a container" do |contained|
  it "has many 'contained' objects"
  it "can iterate on 'contained' objects" 
  it "has a number of 'contained' object"
end
