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
# BDD is an approach that relies on testing to identify the areas of code
# that are not working properly.
# It differs from Test Drive Development in that it relies on the flow of
# data/errors to point the developer to the next step instead of relying on the
# developer to locate said issue.

# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET /examples'
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

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get('/examples')).to route_to('examples#show')
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
      post :create, format: :json

    it 'is succesful and returns JSON object'

    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)).not_to be_nill
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
      patch :update, id: example.id

  it 'is succesful and returns JSON object'
    expect(response.status).to eq(200)
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

  describe 'DELETE destroy' do
    before(:each) do
      delete :destroy, id: examples.id, format: :json
    end
  it 'is succesful and returns empty array'
  expect(resonse_status).to eq(204)
  expect(response.body).to be_empty
  end
end
