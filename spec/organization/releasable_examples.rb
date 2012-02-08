# Spec requirements
require 'organization/spec_helper'

module Lims::Core::Organization
  shared_examples "releasable" do

    it "should be releasable" do
       described_class.new.is_a?(Releasable).should eq true
    end

    context "when it's been released" do
      it "should have an accession number"
      it "can have it's accession number modified"
    end

    context "to be releasable" do
      it "should have data release attribute set"
      it "should have data release policy set"
    end

    context  "to be sent to EBI" do
      it "should have an XML file" #might be xml generator 
    end
  end
end
