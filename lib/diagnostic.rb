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

# Its a method of development where an app is designed be describing how it's
# behavior would appear to a user. It's meant ot be used to test the
# functionality of an application. One difference is in explaining the tests,
# the explanations look more like normal reading than TDD.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  describe 'GET /articles' do
  it 'lists all articles' do
    get '/articles'

    expect(response).to be_success
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples to the examples#show action' do
  expect(get '/examples').to route_to('examples#show')
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
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      articles_response = JSON.parse(response.body)
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
      patch :update, example: example_diff, format: :json
    end

    it 'is successful' do
      expect(response).to be_success
      expect(response.status).to eq(201)
    end

    it 'renders a JSON response' do
      articles_response = JSON.parse(response.body)
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
        expect(response). to be_success
      end
  end
end
