require 'rails_helper'

RSpec.describe Api::V1::Autheniticator do
  describe "#authenticator" do
    it "正しいパスワードならTを返す" do

      # undefined method `build' for RSpec:Moduleと言われた
      # classを明確に表すべき。FactoryBot.create か FactoryBot.build　と表記する。

      m = FactoryBot.build(:store)
      expect(Api::V1::Autheniticator.new(m).autheniticate("pw")).to be_truthy
      
    end

    it "誤ったパスワードならFを返す" do
      m = FactoryBot.build(:store)
      expect(Api::V1::Autheniticator.new(m).autheniticate("xx")).to be_falsey
    end
 
    it "パスワードが未設定ならFを返す" do
      m = FactoryBot.build(:store, password: nil)
      expect(Api::V1::Autheniticator.new(m).autheniticate(nil)).to be_falsey
    end
  end

end

# describe Api::V1::StoresController do
#   context '全てのパラメータが揃っている場合' do
#     it '200 OKを返す'
#     it '成功時のJSONレスポンスを返す'
#     it 'ユーザを登録する'
#   end

#   context 'emailパラメータが不足している場合' do
#     it '400 Bad Requestを返す'
#     it 'パラメータ不正のJSONレスポンスを返す'
#     it 'ユーザを登録しない'
#   end

#   context 'emailが既に登録されている場合' do
#     it '400 Bad Requestを返す'
#     it 'email重複エラーのJSONレスポンスを返す'
#     it 'ユーザを登録しない'
#   end

#   context '管理者アカウント未ログインの場合' do
#     it '401 Unauthorizedを返す'
#     it 'ユーザを登録しない'
#   end
# end