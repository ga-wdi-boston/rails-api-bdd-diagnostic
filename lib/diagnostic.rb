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

# BDD is less rigid than TDD and is written more like sentences
# than TDD.  It tests for behaviors of API requests to make sure that they
# are getting sent and returned correctly

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  before(:each) { get :index }
  it 'is succesful' do
    expect(response.status).to eq(200)
  end

  it 'renders a JSON response' do
    examples_collection = JSON.parse(response.body)
    expect(examples_collection).not_to be_nil
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get '/examples/1').to route_to(
      controller: 'examples',
      action: 'show',
      id: '1'
    )
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
      post :create, example: article_params, format: :json
  end

  it 'renders a JSON response' do
    get :show, id: example.id
    example_response = JSON.parse(response.body)

    expect(example_response).not_to be_nil
    expect(example_response['id']).to eq(example.id)
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

  it 'is successful' do
      patch :update, id: example.id, example: example_diff, format: :json
  end

  it 'renders a JSON response' do
    get :show, id: example.id
    example_response = JSON.parse(response.body)

    expect(example_response).not_to be_nil
    expect(example_response['id']).to eq(example.id)
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
    end

  it 'renders a JSON response' do
      expect(example['id']).to be_nil
    end
end
