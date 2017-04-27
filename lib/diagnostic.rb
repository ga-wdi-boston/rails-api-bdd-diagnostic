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

# Behavior driven development is driven by user stories looking at the end result
# of your app.  Test driven development is when you create tests before each step
# and base your programming on that.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  it 'gets the examples list' do
    expect(get('/examples')).to be_success
    expect(response.body).to_be not_nil
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'gets example routes' do
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
    before(:each) do
      post :create, params: { example: example_params }
    end

    it 'posts successfully' do
      expect(response).to be_success
    end

    it 'renders JSON' do
      article_response = JSON.parse(response.body)
      expect(article_response).not_to be_nil
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
      patch :update, id: article.id,
            params: { example: example_diff }
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders JSON' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
      expect(example_response[:body]).to eq(example_diff[:body])
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
    it 'is successful and returns an empty response' do
      delete :destroy, params: { id: example.id }

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

# This is all just a wild guess

RSpec.describe Example do
  describe 'associations' do
    # association method here
    def association
      Example.has_many 'others'
    end

    # test association with `other` here
    it 'checks association' do
      expect(get('example/1').other_id).to_be success
    end
  end
end
