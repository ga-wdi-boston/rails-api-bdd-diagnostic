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

# Behavior Driven Development is a process used to limit the amount of debugging
# that needs to be done when writing code. It is a methodical process that
# allows you to create a series of unit tests for each unit that makes up a
# feature of your code. It tests each unit of code as it is being written, until
# a full feature is created. That feature can then be tested and upon success
# you can move onto the next feature and the units within it.

# source: class notes
# comfort: 3
# clarity: 3

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  def example_params
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  def examples
    Example.all
  end

  def example
    Example.first
  end

  before(:all) do
    Example.create!(example_params)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples'

      expect(response).to be_success

      examples_response = JSON.parse(response.body)
      expect(examples_response.length).to eq(examples.count)
      expect(examples_response.first['title']).to eq(example[:title])
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

  describe 'POST create' do
    before(:each) do
        post :create, example: example_params, format: :json
      end

      it 'is successful' do
        expect(response.status).to eq(201)
      end

      it 'renders a JSON response' do
        example_response = JSON.parse(response.body)
        expect(example_response).not_to be_nil
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
        expect(response.status).to eq(200)
      end

      it 'renders a JSON response' do
        example_response = JSON.parse(response.body)
        expect(example_response).not_to be_nil
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
      delete :destroy, id: example.id

      expect(response.status).to eq(204)
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
