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

# BBD is when user stories and desired behavior of software is used to build a
# testing scheme. This allows the developer to the limit the scope of the project
# to test that the features necessary for implementation are working, while not
# focusing time and energy on things that may take away from core functionality.
# It is essentially the collaboration of business operations and technical testing.
# BDD originally stemmed from TDD and is similar but attenttive to users and
# what other players the development of the product, outside of programmers, would
# like to see in the product.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do


  describe 'GET /examples' do
    it 'lists all examples' do
      get '/examples'

      expect(response).to be_success

      examples_response = JSON.parse(response.body)
      expect(examples_response.length).to eq(examples.count)
      expect(examples_response.first['content']).to eq(examples['content'])
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show actions' do
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
      # expect(reponse).to be(success)
    end

    it 'renders a JSON response' do
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
      patch :update, id: example.id, article: article_diff, format: :json
    end

    it 'is successful' do
      expect(response.status).to eq(200)
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
  before (:each) do
    delete :destroy, id: example.id
  end
  it 'is successful' do
    expect(response.status).to eq(204)
    expect(response.body).to be_empty
  end
end
