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

# behavior driven development is writing code first, then a test that produces the same error,
# test driven development is writing the test first, then the code to make it pass

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  def examples
    Example.all
  end

  # feature test
  # we're describing what happens when a get request is made to
  # /examples
  describe 'GET /examples' do
    # we expect the get request to return a list of all the examples
    it 'lists all examples' do
      # get is a function that takes a string, and makes a get
      # request to that address
      get '/examples'
      # Expect to get a 20x response (success)
      expect(response).to be_success

      # sets the variable examples_response to the body of the
      # http response
      examples_response = JSON.parse(response.body)
      # expect the list of examples that we get from the server to be
      # the same length as the list of examples we created
      expect(examples_response.length).to eq(examples.count)
      # check that the first example's title is equal to the example title
      # that we createds
      expect(examples_response.first['title']).to eq(example['title'])
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
    # your test(s) here
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
