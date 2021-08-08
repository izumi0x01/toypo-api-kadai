require 'rails_helper'

RSpec.describe Api::V1::Autheniticator do
  describe "#authenticator" do
    it "正しいパスワードならT" do

      # undefined method `build' for RSpec:Moduleと言われた
      # FactoryBot.create か FactoryBot.build　と表記する。

      m = FactoryBot.build(:store)
      expect(Api::V1::Autheniticator.new(m).autheniticate("pw")).to be_truthy
      
    end

    it "誤ったパスワードならF" do
      m = FactoryBot.build(:store)
      expect(Api::V1::Autheniticator.new(m).autheniticate("xx")).to be_falsey
    end
 
    it "パスワードが未設定ならF" do
      m = FactoryBot.build(:store, password: nil)
      expect(Api::V1::Autheniticator.new(m).autheniticate(nil)).to be_falsey
    end
  end

end

RSpec.describe Store, type: :model do
  before do 
    @store = FactoryBot.build(:store)
  end

  describe 'バリデーション' do
    it '全てのパラメータに値が設定されていればT' do
      expect(@store.valid?).to be_truthy
    end

    it 'store_nameが空の時にF' do
      @store.store_name = ''
      expect(@store.valid?).to be_falsey
    end

    it 'emailが空の時にF' do
      @store.email = ''
      expect(@store.valid?).to be_falsey
    end
  end
end

describe Api::V1::StoresController do

  describe "新規登録" do
    # buildではオブジェクトを返す。attributes_forではハッシュを返す。
    let(:params_hash){FactoryBot.attributes_for(:store)}

    it "データが作成されていればT" do
      
      puts params_hash
      expect{post :create, params: {store: params_hash}}.to change(Store, :count).by(1)
    end

    it "リクエストが成功すればT" do
      post :create, params: {store: params_hash}
      expect(response).to have_http_status "200"
    end
  end

end