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

# As the name implies test driven development is when you have tests that drive
# your software development as opposed to behavior driven development which is meant
# to eliminate issues that TDD might cause. BBD is when developers write behavior and
# specification that drives software development.

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
      expect(examples_response.length).to eq(exmaples.count)
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples to the examples#index action' do
  expect(get '/examples').to route_to('examples#index')
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
        expect(example_response['name']).to eq(example_params[:name])
      end
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

      it 'renders a JSON response' do
        example_response = JSON.parse(response.body)
        expect(example_response).not_to be_nil
        expect(example_response['body']).to eq(example_params[:body])
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
    before :each do
      @example = Example(:id)
    end
  end

  it "deletes the example" do
   expect{
     delete :destroy, id: @example
   }.to change(Example,:count).by(-1)
  end

  it "redirects to examples#index" do
    delete :destroy, id: @example
    response.should redirect_to examples_url
  end

  it 'is successful and returns an empty response' do
    expect(response.status).to eq(204)
  end
end
