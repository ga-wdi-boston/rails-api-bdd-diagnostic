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

# BDD is about testing behavior of code - not how it's implemented. So in a way it shouldn't have too many specifics. Even if the code you're testing is going to be implemented in a very specific way, your BDD test shouldn't test the code only in that specific way. It should make sure the code works with other values, so that if implementation changes in the future, it won't break. TDD is a process for writing tests. It suggests that one should start by writing a test that will fail, then writing code to pass the test. This should make a certain segment succeed, while other tests fail. Good, continue debugging one error at a time through your unit tests and eventually feature tests. Always write tests before the code.

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

      examples_response = JSON.parse(response.body)
      expect(examples_response.length).to eq(examples.count)
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  describe 'GET /examples/:id' do
    it 'shows one example' do
      get "/articles/#{example.id}"

      expect(response).to be_success
      example_response = JSON.parse(response.body)
    end
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
    it 'creates an example' do
      post '/articles', params: { example: example_params }

      expect(response).to be_success
      new_example = JSON.parse(resonse.body)
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
    it 'updates an exmaple' do
      patch("/examples/#{example.id}", params: { example: example_diff })

      expect(response).to be_success
      updated_example = JSON.parse(response.body)
      expect(updated_example[':body']).to eq(example_diff[':body'])
    end
    it 'doesn\'nt update an article with bad params' do
      patch("/examples/#{example.id}", params: { example: nil })

      expect(response).to eq(422)
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
    it 'deletes an example' do

      example_response = JSON.parse(response.body)
      expect(example_response).to be_empty
      expect(example).to be_a(Object)
      delete "/examples/#{example.id}"
      expect(example).to be_nil
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
    it 'associates with an other' do

    end
    # test association with `other` here
  end
end
