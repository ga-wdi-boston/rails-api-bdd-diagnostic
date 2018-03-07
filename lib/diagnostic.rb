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

# Behavior driven development refers to a testing method that results in
# developing tests fo functionality as you need them. Test driven Development
# refers to a testing method whereby you develop tests after-the-fact.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do

  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples'

      expect(response).to be_success

      parsed_resp = JSON.parse(response.body)
      expect(parsed_resp.length).to eq(examples.count)
      expect(parsed_resp.first['some_property']).to eq(article['some_property'])
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
    expect(get('/examples/3')).to route_to(
      controller: 'examples',
      id: '3',
      action: 'show'
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
    # your test(s) here
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
      patch :update, params: { id: example.id, example: example_diff }
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['body']).to eq(example_diff[:body])
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
    prior_example = example

    before(:each) { get :destroy, params: { id: example.id } }

    it 'is successful and returns an empty response' do
      expect(response.status).to eq(204)
      expect(response.body).to be_empty
    end

    it 'is successful and the resource is deleted' do
      new_example = example
      expect(prior_example['body']).to_not eq(new_example['body'])
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
