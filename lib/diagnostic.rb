# frozen_string_literal: true
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

# BDD is a testing [philosophy?] where the tests are high-level using business logic,
# and is from the user view/perspective and bsed on user stories.
# Basically build the tool/feature/app, test the finished product.
# BDD is different from TDD in that TDD is more focused on smaller pieces of code
# at a time, are run before, during, and after a tool/feature/app is built.
# Usually TDD is testing first with a failing test then coding to fix a test failure,
# then retesting to fix another, etc. until no more test failures exist.
#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'Examples API' do
  def example_params
    {
      title: 'An example',
      content: 'Trying out this item'
    }
  end

  def examples
    # returns a list of all examples
    Example.all
  end
  before(:all) do
    Example!(example_params)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'GET /examples' do
  it 'lists all examples' do
    get '/examples'
    expect(response).to be_success
    examples_response = JSON.parse(response.body)
    expect(examples_response.length).to eq(examples.count)
    expect(examples_response.first['title']).to eq(example['title'])
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
    expect(get('examples/1')).to route_to(
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

  def example
    Example.first
  end

  before(:all) do
    Example.create!(example_params)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'POST create' do
    before(:each) do
      post :create, params: { example: example_params }
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

  def example
    Example.first
  end

  before(:all) do
    Example.create!(example_params)
  end

  after(:all) do
    Example.delete_all
  end

  describe 'PATCH update' do
    before(:each) do
      patch :update, params: {
        id: example.id,
        example: example_diff
      }
    end

    it 'is successful and returns an empty response' do
      expect(response.status).to eq(204)
      expect(response.body).to be_empty
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

  ddescribe 'DELETE destroy' do
    it 'is successful and returns an empty response' do
      delete :destroy, params: { id: example.id }

      expect(response).to be_successful
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
  after(:all) do
    Example.delete_all
  end

  describe 'associations' do
    def association
      described_class.reflect_on_association(:comments)
    end

    it 'has many comments' do
      expect(association).to_not be_nil
      expect(association.name).to eq(:comments)
    end

    it 'has a set inverse of record' do
      expect(association.options[:inverse_of]).to_not be_nil
      expect(association.options[:inverse_of]).to eq(:example)
    end

    it 'validates the presence of a example\'s content' do
      expect(Example.create(title: 'You shall not pass')).to be_invalid
    end

    it 'validates the presence of a example\'s title' do
      expect(Example.create(content: 'You shall not pass')).to be_invalid
    end
  end
end
