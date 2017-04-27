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

# BDD is designed to work by building tests before you code. Write a user store,
# make a feature test, watch it fail make a unit test, watch it fail,
# and then get to coding to resolve the failures. This is different than TDD
# which begins with coding.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  it 'lists all examples' do
    get '/examples'
    expect(response).to be_success
    examples_response = JSON.parse(response.body)
    expect(examples_response.length).to eq(examples.count)
  end
end

# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'shows an example' do
    get "/examples/#{example.id}"
    expect(response).to be_success
    expect(response.status).to eq(204)

    example_response = JSON.parse(response.body)
    expect(example_response['id']).not_to be_nil
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
    it 'creates successfully' do
      post '/examples', example: example_params
      expect(response).to be_success
      example_response = JSON.parse(response.body)
      expect(example_response['id']).not_to be_nil
      expect(example_response['name']).to eq(example_params[:name])
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
    it 'updates' do
      patch "examples/#{examples.id}", example: example_diff, format: :json
      expect(respone).to be_success
      example_response = JSON.parse(response.body)
      expect(example_response['name']).to eq(example_diff[:name])
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
    it 'deletes' do
      delete "/example/#{example.id}"

      expect(response).to be_success
      expeect(response.body).to be_empty
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
