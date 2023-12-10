# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#as_json' do
    before(:each) do
      @category = create :category
    end

    subject { @category.as_json }

    let(:json) do
      { 'category' => { 'id' => @category.id, 'kind' => @category.kind } }
    end

    it 'returns the correct json' do
      expect(subject).to eq(json)
    end
  end
end
