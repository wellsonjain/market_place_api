require 'rails_helper'

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive_message_chain(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      allow(authentication).to receive_message_chain(:current_user).and_return(nil)
      allow(response).to receive_message_chain(:response_code).and_return(401)
      allow(response).to receive_message_chain(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive_message_chain(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it {  should respond_with 401 }
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive_message_chain(:current_user).and_return(@user)
      end

      it { should be_user_signed_in }
    end

    context "when there is no uer on 'session'" do
      before do
        @user = FactoryGirl.create :user
        allow(authentication).to receive_message_chain(:current_user).and_return(nil)
      end

      it { should_not be_user_signed_in }
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      allow(authentication).to receive_message_chain(:current_user).and_return(nil)
      allow(response).to receive_message_chain(:response_code).and_return(401)
      allow(response).to receive_message_chain(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive_message_chain(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it { should respond_with 401 }
  end
end