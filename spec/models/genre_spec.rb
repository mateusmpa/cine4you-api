# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe '#as_json' do
    before(:each) do
      @genre = create :genre
    end

    subject { @genre.as_json }

    let(:json) do
      { 'genre' => { 'id' => @genre.id, 'kind' => @genre.kind } }
    end

    it 'returns the correct json' do
      expect(subject).to eq(json)
    end
  end
end
