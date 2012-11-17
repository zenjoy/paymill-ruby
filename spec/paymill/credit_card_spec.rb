# -*- encoding: utf-8 -*-
require "spec_helper"

describe Paymill::CreditCard do
  let(:valid_attributes) do
    {
      card_type:    "visa",
      country:      "germany",
      expire_month: 10,
      expire_year:  2013,
      card_holder:  "Tobias Fuenke",
      last4:        "2345"
    }
  end
  
  let(:paymill_example_attributes) do
    {
     :id=>"pay_3af44644dd6d25c820a8",
     :created_at=>1349942085,
     :updated_at=>1349942085,
     :client=>nil,
     :type=>"creditcard",
     :card_type=>"visa",
     :country=>nil,
     :expire_month=>10,
     :expire_year=>2013,
     :card_holder=>'Tobias Fuenke',
     :last4=>"2345" 
    }
  end
 
  let (:payment) do
    Paymill::CreditCard.new(valid_attributes)
  end

  describe "initialize" do
    it "initializes all attributes correctly" do
      payment.card_type.must_equal "visa"
      payment.country.must_equal "germany"
      payment.expire_month.must_equal 10
      payment.expire_year.must_equal 2013
      payment.card_holder.must_equal "Tobias Fuenke"
      payment.last4.must_equal "2345"
    end
  end

  describe "number" do
    it "should return a formatted number" do
      payment.number.must_equal "•••• •••• •••• 2345"
    end
    
    it "should return a formatted number with custom settings" do
      payment.number(placeholder: '*', separator: ':').must_equal '****:****:****:2345'
    end
    
    it "should return this last 4 digits" do
      payment.last4.must_equal "2345"
    end
  end

  describe "holder" do
    it "should return the holders name" do
      payment.holder.must_equal "Tobias Fuenke"
    end
  end
  
  describe "collection_name" do
    it "should have the correct collection name" do
      payment.class.collection_name.must_equal 'payments'
    end
    
    it "should get the correct api path from collection name" do
      payment.class.api_path.must_equal 'payments'
      payment.class.api_path(1, "test").must_equal 'payments/1/test'
    end
  end

  describe "find" do
    it "makes a new GET request using the correct API endpoint to receive a specific creditcard" do
      skip
      Paymill.should_receive(:request).with(:get, "payments/123", {}).and_return("data" => {})
      Paymill::CreditCard.find("123")
    end
  end

  describe "all" do
    it "makes a new GET request using the correct API endpoint to receive all creditcards" do
      skip
      Paymill.should_receive(:request).with(:get, "payments", {}).and_return("data" => {})
      Paymill::CreditCard.all
    end
  end

  describe "create" do
    it "makes a new POST request using the correct API endpoint" do
      skip
      Paymill.should_receive(:request).with(:post, "payments", valid_attributes).and_return("data" => {})
      Paymill::CreditCard.create(valid_attributes)
    end
  end
end
