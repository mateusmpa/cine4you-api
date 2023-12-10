# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#good?' do
    before(:each) do
      category = create :category
      genre = create :genre
      catalog = create :catalog, category_id: category.id, genre_id: genre.id
      user = create :user
      @review = create :review, rating: rating, catalog_id: catalog.id, user_id: user.id
    end

    subject { @review.good? }

    context 'when rating is greater than 5' do
      let(:rating) { rand(4..5) }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when rating is less than 5' do
      let(:rating) { rand(1..2) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when rating is equal to 5' do
      let(:rating) { 3 }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end

  describe '#neutral?' do
    before(:each) do
      category = create :category
      genre = create :genre
      catalog = create :catalog, category_id: category.id, genre_id: genre.id
      user = create :user
      @review = create :review, rating: rating, catalog_id: catalog.id, user_id: user.id
    end

    subject { @review.neutral? }

    context 'when rating is greater than 5' do
      let(:rating) { rand(4..5) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when rating is less than 5' do
      let(:rating) { rand(1..2) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when rating is equal to 5' do
      let(:rating) { 3 }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
  end

  describe '#bad?' do
    before(:each) do
      category = create :category
      genre = create :genre
      catalog = create :catalog, category_id: category.id, genre_id: genre.id
      user = create :user
      @review = create :review, rating: rating, catalog_id: catalog.id, user_id: user.id
    end

    subject { @review.bad? }

    context 'when rating is greater than 5' do
      let(:rating) { rand(4..5) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when rating is less than 5' do
      let(:rating) { rand(1..2) }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when rating is equal to 5' do
      let(:rating) { 3 }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end

  describe '#format_updated_at' do
    before(:each) do
      category = create :category
      genre = create :genre
      catalog = create :catalog, category_id: category.id, genre_id: genre.id
      user = create :user
      @review = create :review, catalog_id: catalog.id, user_id: user.id
    end

    subject { @review.format_updated_at }

    let(:updated_at) { I18n.l(@review.updated_at) }

    it 'returns the correct updated_at' do
      expect(subject).to eq(updated_at)
    end
  end

  describe '#as_json' do
    before(:each) do
      category = create :category
      genre = create :genre
      catalog = create :catalog, category_id: category.id, genre_id: genre.id
      user = create :user
      @review = create :review, catalog_id: catalog.id, user_id: user.id
    end

    subject { @review.as_json }

    let(:json) do
      {
        'review' => {
          'id' => @review.id,
          'rating' => @review.rating,
          'comment' => @review.comment,
          'catalog_id' => @review.catalog_id,
          'user_id' => @review.user_id,
          'good?' => @review.good?,
          'neutral?' => @review.neutral?,
          'bad?' => @review.bad?,
          'format_updated_at' => @review.format_updated_at,
          'user' => {
            'id' => @review.user.id,
            'name' => @review.user.name
          }
        }
      }
    end

    it 'returns the correct json' do
      expect(subject).to eq(json)
    end
  end
end
