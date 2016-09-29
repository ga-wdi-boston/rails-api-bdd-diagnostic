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

# Behavior Driven Development is the process of using tests that dictate the expected
# behavior of a program to help you write the program itself. It is meant to be used
# during development, and to help you down the line as you refactor and return to the code
# in the future, to ensure that any future changes you make do not break the whole
# thing, and if they do, it's easier to identify when and where that happened.
# BDD is very similar to TDD, but BDD tends to use code that is more similar to English
# and more easily readable.

# Source: http://joshldavis.com/2013/05/27/difference-between-tdd-and-bdd/

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
      example_response = JSON.parse(response.body)
      expect(example_response.length).to eq(examples.count)
      expect(example_response.first['name']).to eq(example[:name])
    end
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
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
    end

    it 'renders a JSON response' do
      example_response = JSON.parse(response.body)
      expect(example_response).not_to be_nil
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
      expect(response.status).to eq(200)
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

  describe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
      delete :destroy, id: example.id

      expect(response.status).to eq(204)
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
    # association method here
    def other_association
      described_class.reflect_on_association(:other)
    end
    # test association with `other` here
    it 'has the name other' do
      expect(other_association).to_not be_nil
      expect(other_association).to eq(:other)
    end

    it 'has a set inverse of record' do
      expect(other_association.options[:inverse_of]).to_not be_nil
      expect(other_association.options[:inverse_of]).to eq(:other)
    end

    it 'deletes associated information when destroyed' do # this may not be necessary depending on our data
      expect(other_association.options[:dependent]).to eq(:destroy)
    end
  end
end
