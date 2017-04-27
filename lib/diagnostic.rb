# frozen_string_literal: true
require 'rails_helper'

# Instructions:
# The tests you build for this diagnostic are not expected to pass.
# Merely provide a test for each given scenario.

def examples
  Example.all
end

def example
  Example.first
end

#
# Question 1
#
# In a Ruby comment, explain Behavior Driven Development, how it is meant to be
# used, and how it differs from Test Driven Development.

Behavioral driven development begins with a User story and is based on the actions a user
will perform. Test Driven development is focused more on satisfying tests that are created
prior to coding.
#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  def examples
  example.all
  end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
it 'routes GET /examples/:id to the examples#show action' do
  expect(get('examples/1')).to route_to(
  name: 'Example name',
  body: 'What a fantastic example this is...'
  )
  end
end

#
# Question 4
#
# Test that a POST action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  def example_params
    {
      name: 'Example name',
      body: 'What a fantastic example this is...'
}
  end
describe 'POST create' do
  def new_example
    {
      name: 'Example name',
      body: 'What a fantastic example this is...'
  }
  end
  before(:each) do
    post :create, example: new_example, format: :json
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  describe 'PATCH update' do
    def example_diff
    {
      body: 'Actually not that bad.'
    }
    end

    before(:each) do
    patch :update, id: example.id, example: example_diff, format: :json
  end

  it 'is successful' do
    expect(response.status).to eq(204)
    expect(response.body).to be_empty
end
end


#
# Question 6
#
# Test that a DELETE action from our ExamplesController is both successful
# and renders an empty response.

RSpec.describe ExamplesController do
  def example
    Example.first
  end

  describe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
    delete :destroy, id: example.id

    expect(response.status).to eq(204)
    expect(response.body).to be_empty
  end
end

#
# Question 7
#
# Test that the Example model has an association with an
# `other` model. You'll have to build an `association` model
# on your own.

RSpec.describe Example do
  describe 'associations' do
    # association method here

    # test association with `other` here
  end
end
