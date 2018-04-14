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

# TDD is when you write tests expecting them to fail untill you actually write the logic in your app to make the test pass.
# BDD is the technique of coming up with what you believe the behavior should be for a user and write tests and code to match that behavior.
#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  get '/examples'
  expect(response).to be_success
  examples_response = JSON.parse(response.body)
  expect(response.count).to eq(examples.count)
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  get '/examples/', params: { example: example }
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
    it 'routes GET /examples/:id to the examples#show action' do
      expect(get('/examples/2')).to route_to(
        controller: 'examples',
        action: 'show',
        id: '1'
      )
    end
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
    before(:each) do
      patch :update, id: example.id, example: example_diff, format: :json
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
    end
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
    before(:each) {
      delete :destroy, id: example.id, format: :json
    }

    it 'is successful' do
      expect(response).to be_success
    end

    it 'returns an empty response body' do
      # use before(:all) so we only delete once and test response object multiple times?
      expect(response.body).to be_empty
    end
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
  end
end
