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

# The main difference with BDD is how it is written like english sentences, it
# seems like there can be an argument made for BDD connecting the gap between what
# you're trying to test for and what you're actually test for by how it's being
# written, and not getting bogged down in the test code. It seems like either
# can be effective but that maybe BDD is more accessible in how it helps you to
# think about what you're testing more semantically, hence making your tests better.

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
    it 'gets /examples' do
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
  it 'routes GET /examples to the examples#show action' do
    expect(get('/examples')).to route_to('examples#show')
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

  describe 'POST /exampes' do
    it 'creates an example' do
      post '/exampes', example: example_params, format: :json

      expect(response).to be_success

      example_response = JSON.parse(response.body)

      expect(example_response).not_to be_nil
      expect(example_response['name', 'body']).to eq(comment_params[:name, :body])
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

  before(:each) do
    patch :update, id: example.id, example: example_diff, format: :json
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

  describe 'DELETE destroy' do
  before(:each) do
    delete :destroy, id: example.id, format: :json
  end
  it 'is successful and returns an empty response' do
    expect(response.status).to eq(204)
    expect(response.body).to be_empty
  end
end
