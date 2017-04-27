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

# your answer here
# Behavior Driven Development is accomplished by coding your features first, before building tests to test your code.
# Test Driven Development is done by writing the tests first and then actually coding your feature.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  # your test(s) here
  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples'

      expect(response).to be_success
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  # your test(s) here
  it 'routes GET /examples/:id to the examples#show action' do
  expect(get('/examples/1')).to route_to(
    controller: 'examples',
    action: 'show',
    id: '1'
  )
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
    # your test(s) here

    it 'is succesful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      example_params = JSON.parse(response.body)
      expect(example_params).not_to be_nil
      expect(example_params.first['name']).to eq(example['name'])
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
    # your test(s) here
    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      example_diff = JSON.parse(response.body)
      expect(example_diff).not_to be_nil
      expect(example_diff[:title]).to eq(example_diff[:title])
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
    # your test(s) here
    it 'is successful and returns an empty response' do
      delete :destroy, params: { id: article.id }
      expect(response).to be_success
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
    # association method here

    # test association with `other` here
  end
end
