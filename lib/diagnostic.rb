# frozen_string_literal: true
require 'rails_helper'

# Instructions:
# The tests you build for this diagnostic are not expected to pass.
# Merely provide a test for each given scenario.

def examples
  render json: Example.all
end

def example
  Example.first
end

#
# Question 1
#
# In a Ruby comment, explain Behavior Driven Development, how it is meant to be
# used, and how it differs from Test Driven Development.

BDD is when you use your use cases to build tests after code has been written.
TDD is when you develop your tests first before building your code.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET index' do
    before(:each) { get :index }
    it 'is succesful' do
      expect(response.status).to eq(204) # be_success
    end

    it 'renders a JSON response' do
      # takes the JSON in the response and makes it into a Ruby object
      # that we can manipulate. Assigns that object to example_collection.
      examples_collection = JSON.parse(response.body)

      expect(examples_collection).not_to be_nil
      expect(examples_collection.first['title']).to eq(example['title'])
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples to the examples#index action' do
    expect(get('/examples')).to route_to('examples#index')
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
        title: 'Testing iz gr8',
        content: 'Except when it\'s not'
      }
    end

    before(:each) do
      post :create, params: { example: new_example }, format: :json
    end

    it 'is successful' do
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  def example_diff
    {
      body: 'This actually isn\'t that fantastic of an example...'
    }
  end

  describe 'PATCH update' do
    def example_diff
      { title: 'Two Stupid Tricks' }
    end

    before(:each) do
      patch :update, params: {
        id: example.id,
        example: example_diff
      },
                     format: :json
    end

    it 'is successful and returns an empty response' do
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
    # your test(s) here
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
