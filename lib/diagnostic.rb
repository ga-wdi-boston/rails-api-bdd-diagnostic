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

Behavior Driven Development focuses on unit testing.  Unit tests isolate small
pieces of code so that you can be more specific with finding bugs.

Test Driven Development relies on the repitition of a cycle that consists of
the following steps:

Add a test
Run all tests and see if the new one fails
Write some code
Run tests
Refactor code
Repeat

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

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  it 'routes GET /examples/:id to the examples#show action' do
    expect(get('examples/3')).to route_to(controller: 'examples',
                                          action: 'show',
                                          id: '3')
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
    @example = current_user.examples.build(example_params)

  if @example.save
    render json: @example, status: :created
  else
    render json: @example.errors, status: :unprocessable_entity
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
    if @example.update(example_params)
      head :no_content
    else
      render json: @example.errors, status: :unprocessable_entity
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
    @example.destroy

    head :no_content
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
    belongs_to :other
    validates :text, :user, presence: true

    # test association with `other` here
  end
end
end
