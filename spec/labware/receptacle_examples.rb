# Spec requirements
require 'labware/spec_helper'

shared_examples "receptacle" do
  def self.its_chemical_content (spec, &block)
    spec_name = "has a chemical content which #{spec}"
    if block
      it spec_name &block
    else
      it spec_name
    end
  end
  it "has a chemical content"
  its_chemical_content "can be removed partially"
  its_chemical_content "can be removed totally"
  it "can have a chemical content added to it"
end

