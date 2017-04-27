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
BDD is when we write behavior & specification that then drives
our software development. In addition, Behavior-driven development should be
focused on the business behaviors your code is implementing: the “why” behind
the code.

Whereas Test Driven Development is made up of the following tests:
First the developer writes some tests.
The developer then runs those tests and (obviously) they fail because none of
 those features are actually implemented.
Next the developer actually implements those tests in code.
If the developer writes their code well, then the in next stage they will see
that their tests pass.
The developer can then refactor their code, add comments and
clean it up, as they wish because the developer knows that if
the new code breaks something, then the tests will be an alert by failing.

Source:
https://www.toptal.com/freelance/your-boss-won-t-appreciate-tdd-try-bdd

#
# Question 2
#
# Create a request spec for our Examples API that ensures 'GET /examples'
# responds successfully and lists all examples.

RSpec.describe 'GET /examples' do
  it 'lists all examples' do
    get '/examples'

    expect(response).to be_success

    example_response = JSON.parse(response.body)
    expect(example_response.length).to eq(examples.count)
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
    def example_diff
      { title: 'Solution to question 5' }
    end

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
  describe 'associations' do
    # association method here

    # test association with `other` here
  end
end
