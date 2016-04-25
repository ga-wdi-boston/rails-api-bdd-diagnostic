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

#
# Behavior Driven Developement is writing tests that check for how the given code should behave instead of whether is works or not.
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'GET /examples API' do
  it 'lists all examples' do
    get '/examples'

    expect(response).to be_success
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'it routes GET /examples/:id to the examples#show action' do
  expect(get('/examples/1')).to route_to(
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
      post :create, examples: example_params, format: :json
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      expect(JSON.parse(response.body)).not_to be_nil
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
    expect(JSON.parse(response.body)).not_to be_nil
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

at  describe 'DELETE destroy' do
  it 'is successful and returns an empty response' do
      expect(response).to be_success

      expect(response.body).to be_empty
    end
  end
