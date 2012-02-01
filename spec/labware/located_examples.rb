# Spec requirements
require 'labware/spec_helper'

shared_examples "located" do
  it "has a location"
end

shared_examples "movable" do
  it "be moved from somewhere to somewhere else"
end

# Maybe not needed
shared_examples "has an history location" do
  it "has a location at a specific time"
end
