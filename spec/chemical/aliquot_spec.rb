# Spec requirements
require 'chemical/spec_helper'

# Model requirements
require 'lims/core/chemical/aliquot'

module Lims::Core::Chemical
  describe Aliquot do
    context "to be valid" do
      it "should have an owner"
      it "should have type" do
        # this is an example to mostly test yard-rspec.
        a = Aliquot.new
        a.type=nil
        a.valid?.should fail_with("todo")
      end
      it "should have a quantity"
      it "should be in a receptacle"
      it "can't be empty"
    end
  end
end
