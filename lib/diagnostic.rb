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

# your answer here

# Behavior driven development follows a process of writing a test for the
# functionality that you expect from a feature or unit, running it, seeing the
# test fail, then writing the code to get the feature to pass that test, then
# proceeding to write the # test for the next bit of functionality, failing,
# writing the code, etc.
# The difference between test driven development and behavior driven development
# is that behavior driven development is more semantic than TDD, writing the tests
# to read like english, making it easier to follow, allowing you to write better
# and more comprehensive tests.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'GET /examples' do
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
    expect(get '/examples').to route_to(
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
      post :create, example: example_params, format: :json
    end

    it 'is successful' do
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
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
    before(:each) do
      patch :update, id: example.id, example: example_diff, format: :json
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
     expect(example_response).not_to be_nil
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

  at describe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
      delete :destroy, id: example.id, format: :json

      expect(response).to be_successful
      expect(response.body).to be_empty
    end
  end
end
