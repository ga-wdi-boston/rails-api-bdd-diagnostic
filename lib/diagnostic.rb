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

# BDD is feature focused where as TDD is test focused. In TDD you build
# your tests first and then code for you test. With BDD tests can be done
# after your code - backfilling.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  def example
      Example.first
  end

  describe 'GET /examples' do
  it 'lists all examples' do
    get '/examples'

    expect(response).to be_success
    # from rails app /blackbox
    examples_response = JSON.parse(response.body)

    expect(examples_response.length).to eq(examples.count)
    expect(examples_response.first['title']).to eq(example['title'])
  end
end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
  expect(get('/examples/1')).to route_to(
  controller: 'examples',
  action: 'show',
  id: '1'
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
  before(:each) do
    post :create, params: { example: example_params }
  end
  describe 'POST create' do
    # your test(s) here
  end
  expect(response.status).to eq(200)
   example_post = JSON.parse(response.body)
  expect(example_post).not_to be_nil
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
      patch :update, params: { id: example.id, example: example_diff }
    end

  it 'is successful' do
    expect(response).to be_successful
  end
  it 'renders a JSON response' do
     expect(response.body).to_not be_empty
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
    delete :destroy, params: { id: example.id }

    expect(response).to be_successful
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
