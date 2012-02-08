require 'actions/spec_helper'

shared_examples "an action" do
  it "has a user"
  it "has a title"

  # @todo  move in Action::Base spec
  it "should save modified objects"
  it "should create a session with user an title"
end
