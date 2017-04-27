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

# Behavior driven development is writing code and having it initate an error then writing a test to validates that error,
# the writing code that passes the tests, then running the previous tests to see if your new code passes.

#Test Driven Development is a specific order of testing and writing cdode--> 1. write the test, run the test, write the code, run the test, refactor the code, run the test...

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do


  describe 'GET/examples' do
    it 'list all examples'

    expect(response).to be_success
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do

  describe 'GET/examples/:id' do
    it 'show one example' do
      get"/examples/#{example.id}"

      expect(response).to be_success
      example_response = JSON.parse(response.body)
      expect(example_response['id']).not_to be_nill
    end
  end
end

#
# Question 4
#
# Test that a POST action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  describe 'POST /examples' do
    def example_params
      {
        name: 'Example name',
        body: 'What a fantastic example this is...'
      }
    end
    it 'creates a new example' do
    # your test(s) here
    post '/examples', params: { example: new_example }

    expect(response).to be_success
    example_response = JSON.parse(response.body)
    expect(example_response['id']).not_to be_nil
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do

  describe 'PATCH /examples/:id' do
    def example_diff
      {
        body: 'This actually isn\'t that fantastic of an example...'
      }
    end
    it 'updates an example'
    # your test(s) here
    patch "/examples/#{examples.id}", params: { examples: example_diff }
    expect(response).to be_success
    expect(response.body).to be_empty
    expect(example[:body]).to eq(article_diff[:body])
  end
end

#
# Question 6
#
# Test that a DELETE action from our ExamplesController is both successful
# and renders an empty response.

RSpec.describe ExamplesController do
  def example
    Examples.first
  end

  describe 'DELETE destroy' do
    # your test(s) here
    delete "examples/#{example_id}"
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
