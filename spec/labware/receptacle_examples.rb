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

  it "can have a chemical content added to it" do
    r = described_class.new
    r.add([mock(:aliquot), mock(:aliquot)])
  end

  it "can have an aliquot added to it" do
    r = described_class.new
    r << mock(:aliquot)
  end

  context "with a chemical content" do
    subject { described_class.new.tap { |r| r << mock(:aliquot) } }

    it "can have a part of its content taken" do
      subject.take_fraction(0.5).should be_kind_of(Array)
      subject.size.should change_by 1
    end

    it "can have all of its content taken" do
      subject.take()
      subject.content.should be_empty
    end
  end
end

