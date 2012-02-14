# Spec requirements
require 'labware/spec_helper'

Lab=Lims::Core::Labware

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
    subject { described_class.new.tap { |r| r << Lab::Aliquot.new(:quantity=>10) } }

    it "can have a part of its content taken" do
      expect {
        subject.take_fraction(0.3).should be_kind_of(Array)
      }.to change {subject[0].quantity}.by(-3)
    end

    context "after having all of its content taken", :wipy => true do
      subject.content.should be_empty
    end
  end
end

