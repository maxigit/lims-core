# Spec requirements
require 'labware/spec_helper'

# Model requirements
require 'lims/core/labware/aliquot'

module Lims::Core::Labware
  describe Aliquot do
    context "to be valid" do
      let (:aliquot) {Aliquot.new(:quantity=>10)}

      it "must have everything needed" do
        aliquot.valid?.should be_true
      end
      it "must have an owner"
      it "must have a type" do
        # this is an example to mostly test yard-rspec.
        aliquot.type=nil
        aliquot.valid?.should fail_with("todo")
      end
      it "must have a quantity" do
      pending "we might use nil quanity for unknown quantity" do
        aliquot.quantity=nil
        aliquot.valid?.should eq false
      end
      end

      it "must have a positive quantity" do
        aliquot.quantity=-5
        aliquot.valid?.should  be_false
      end

      it "should be in a receptacle"
      it "can't be empty"
    end
  end
end
