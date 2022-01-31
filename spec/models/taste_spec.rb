# Frozen_string_literal: true

require 'rails_helper'

describe 'tasteモデルのテスト' do
  it "有効なオモさ内容の場合は保存されるか" do
    expect(FactoryBot.build(:taste)).to be_valid
  end
end