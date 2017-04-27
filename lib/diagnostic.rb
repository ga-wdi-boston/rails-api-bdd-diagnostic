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

# it is asking what behavior you wnat to get out of an
# application.
# Test Driven Development is a way to see if something passes, then continue
# onto the next part.
#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  it 'shows all examples' do
    get '/articles'

    expect(response).to be_success
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples to the examples#index action' do
    expect(get('/examples')).to route_to('articles#index')
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
        name: 'cherry flavor',
        body: 'pie is good'
      }
    end
    before(:each) do
      post :create, example: example_params, format: :json
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
      { body: 'I need to have pie now.' }
    end

    before(:each) do
      patch :update, id: example.id, example: example_diff, format: :json
    end

    it 'is successful' do
      patch :update, id: example.id, example: example_diff, format: :json
    end

    it 'renders a JSON response' do
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

    it 'is successful and returns an empty response' do
      delete :destroy, id: example.id

      expect(response.status).to eq(204)
      expect(response.body).to be_empty
    end
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
