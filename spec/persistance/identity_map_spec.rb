# Spec requirements
require 'persistance/spec_helper'

# Model requirements
require 'lims/core/persistance/identity_map'




module Lims::Core::Persistance
  class IdentityMapClass
    include IdentityMap
  end

  describe IdentityMapClass do

    context "with a object mapped to an id" do
      let(:id) { 1 }
      let(:object) { "Object 1" }
      before {subject.map_id_object(id,object) }

      it "should find the object by id" do
        subject.object_for(id).should == object
      end

      it "should find the id by object" do
        subject.id_for(object).should == id
      end

      it "should fail when mapping another object with the same id" do
        expect { subject.map_id_object(id, "Object #2") }.to raise_error(IdentityMap::DuplicateIdError)
      end

      it "should fail when mapping another id with the same object" do
        expect { subject.map_id_object(2, object) }.to raise_error(IdentityMap::DuplicateObjectError)
      end

      it "should not fail when mapping it again" do
        expect { subject.map_id_object(id, object) }.not_to raise_error(IdentityMap::DuplicateError)
      end

      it "should yield the object" do
        subject.object_for(id) do |o|
          o.should == object
        end
      end

      it "should not yield if the object can't be found" do
        subject.object_for("wrong id") do |o|
          raise "not found"
        end.should be_nil
      end
    end
  end
end
