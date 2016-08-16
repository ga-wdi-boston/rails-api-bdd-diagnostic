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

# Behavior Driven Development is a way of developing code where you follow the tests and their errors.
# It is used to prevent developers from getting side tracked.
# i dont remember how it differs from test driven dev.

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
  end
end

# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get('/examples/628')).to route_to(
      controller: 'examples',
      action: 'show',
      id: '628'
    )
  end
end

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

  before(:each) do
    post :create, example: example_params, format: :json
  end

  describe 'POST create' do
    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      examples_response = JSON.parse(response.body)
      expect(examples_response).not_to be_nil
      expect(examples_response['name']).to eq(example_params[:name])
    end
  end
end

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

  describe 'PATCH update' do
    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      examples_response = JSON.parse(response.body)
      expect(examples_response).not_to be_nil
      expect(examples_response['body']).to eq(example_diff[:body])
    end
  end
end

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
      expect(response).to be_success
      expect(response.body).to be_empty
    end
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
    def association
      described_class.reflect_on_association(:other)
    end

    it 'has an association with comments' do
      expect(association).to_not be_nil
      expect(association.name).to eq(:other)
    end
  end
end

#
# RSpec.describe Article do
#   describe 'associations' do
#     def association
#       described_class.reflect_on_association(:comments)
#     end
#
#     it 'has an association with comments' do
#       p association
#       expect(association).to_not be_nil
#       expect(association.name).to eq(:comments)
#     end
#
#     it 'has a set inverse of record' do
#       expect(association.options[:inverse_of]).to_not be_nil
#       expect(association.options[:inverse_of]).to eq(:article)
#     end
#
#     it 'destorys associated comments when deleted' do
#       expect(association.options[:dependent]).to eq(:destroy)
#     end
#   end
