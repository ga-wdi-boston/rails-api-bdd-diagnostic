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

Behavior 

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
    # expect(examples_response.first['title']).to eq(example['title'])
  end
end

#
# Question 3
#
# Create a routing spec for our `Examples` resource that ensures
# GET /examples/:id routes to the examples#show action.

RSpec.describe 'routes for examples' do
  get '/examples' => 'examples#index'
  get '/examples/:id' => 'examples#show'
  post '/examples' => 'examples#create'
  patch '/examples/:id' => 'examples#update'
  delete '/examples/:id' => 'examples#destroy'
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

  it 'renders a JSON response' do
    examples_response = JSON.parse(response.body)
    expect(examples_response).not_to be_nil
    expect(examples_response['name']).to eq(example_params[:name])
  end
  end
end

#
# Question 5
#
# Test that a PATCH action from our ExamplesController is both successful
# and renders a JSON response.

RSpec.describe ExamplesController do
  describe 'PATCH update' do
    def example_diff
      {
        body: 'This actually isn\'t that fantastic of an example...'
      }
    end

    before(:each) do
      patch :update, id: example.id, example: example_diff, format: :json
    end

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
      described_class.reflect_on_association(:comments)
    end

    it 'has an association with comments' do
      expect(association).to_not be_nil
      expect(association.name).to eq(:comments)
    end

    it 'has as set inverse of record' do
      expect(association.options[:inverse_of]).not_to be_nil
      expect(association.options[:inverse_of]).to eq(:article)
    end

    it 'destroys associated comments when deleted' do
      expect(association.options[:dependent]).to eq(:destroy)
    end

    describe 'validations' do
      it 'valitdates the presence of title and contet for new articles' do
        expect(
        Article.create(title: 'Test title', content: 'This is content.')
        ).to be_valid

        expect(
        Article.create(content: 'This is content')
        ).to be_invalid
      end
    end
  end
end
