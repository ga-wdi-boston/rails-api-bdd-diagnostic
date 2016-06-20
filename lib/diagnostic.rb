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

# Behavior Driven Development relies on unit specific tests that determine
# whether specific parts of our code are executing the behaviors that we
# desire. It focuses on creating small chunks of 'desired behaviors' that
# are fashioned from the user stories that make up the functionality of our
# application. It utilizes testing but differs from Test Driven Development in
# its emphasis of the behaviors that each unit is supposed to accomplish as they
# relate to user stories.

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
    expect(examples_response.first['name']).to eq(example['name'])
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the exampless#show action' do
    expect(get 'examples/1').to route_to(
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
      expect(response).to be_success
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
    expect(response).to be_success
    expect(response.body).to be_empty
  end
end
end
