# Frozen_string_literal: true

require 'rails_helper'

describe 'categoryモデルのテスト' do
  it "有効なカテゴリー内容の場合は保存されるか" do
    expect(FactoryBot.build(:category)).to be_valid
  end
end
