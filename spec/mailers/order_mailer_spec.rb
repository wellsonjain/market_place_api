require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include Rails.application.routes.url_helpers

  describe ".send_confirmation" do
    before(:all) do
      @order = FactoryGirl.create :order
      @user = @order.user
    end

    subject { OrderMailer.send_confirmation(@order) }

    it "should be set to be delivered to the user from the order passed in" do
      is_expected.to deliver_to(@user.email)
    end

    it "should be set to be send from no-reply@marketplace.com" do
      is_expected.to deliver_from('no-reply@marketplace.com')
    end

    it "should contain the user's message in the mail body" do
      is_expected.to have_body_text(/Order: ##{@order.id}/)
    end

    it "should have the correct subject" do
      is_expected.to have_subject(/Order Confirmation/)
    end

    it "should have the product count" do
      is_expected.to have_body_text(/You ordered #{@order.products.count} products:/)
    end
  end
end
