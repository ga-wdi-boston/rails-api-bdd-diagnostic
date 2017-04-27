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

def others
  Other.all
end

def other
  Other.first
end

#
# Question 1
#
# In a Ruby comment, explain Behavior Driven Development, how it is meant to be
# used, and how it differs from Test Driven Development.

# Behavior driven development is a development methodology centered around feature, unit tests, and ultimately, User Stories (which, in part, distinguihses it from
# test driven development).  BDD involves starting from User stories (examples of app functionality from the perspective of an example user) and writing feature tests
# that will pass when that functionality is in place.  Each user story is then broken into smaller unit tests which test the functionality of a given function, module, or some other unit of code (typically broken down using the single responsibility prinicple?).
#

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'Get /examples' do
    get '/examples'
    response_items = JSON.parse(response.body)
    expect(response).to be_success
    expect(response_items.length).to eq(examples.count)
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it "correctly routes get request with id to #show method" do
  expect(get('examples/1')).to route_to(
  {
  controller:'examples',
  action:'show',
  id:'1'
  })
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
      post :create, example: example_params, format: :json
    end
    it 'is successful' do
      expect(response.status).to eq(201)
    end
    it 'renders a json response' do
      expect(JSON.parse(response.body)).not_to be_nil
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
      expect(response.status).to eq(204)
    end
    it 'renders a json response' do
      expect(JSON.parse(response.body)).not_to be_nil
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
    before(:each) do
      delete :destroy, id: example.id
    end
    it 'is successful' do
      expect(response.status).to eq(200)
      expect(example).to be_nil
    end
    it 'renders an empty response' do
      expect(response.body).to be_empty
    end # your test(s) here
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
