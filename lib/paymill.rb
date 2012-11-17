require "paymill/version"
require "net/http"
require "json"
require "money"

module Paymill
  autoload :Client,           'paymill/client'
  autoload :CreditCard,       'paymill/credit_card'
  autoload :DirectDebit,      'paymill/direct_debit'
  autoload :Offer,            'paymill/offer'
  autoload :Payment,          'paymill/payment'
  autoload :Preauthorization, 'paymill/preauthorization'
  autoload :Refund,           'paymill/refund'
  autoload :Subscription,     'paymill/subscription'
  autoload :Transaction,      'paymill/transaction'
  
  autoload :Scope,            'paymill/support/scope'
  autoload :Request,          'paymill/support/request'
  autoload :Resource,         'paymill/support/resource'
  
  module Concerns
    autoload :Naming,         'paymill/concerns/naming'
    autoload :Crud,           'paymill/concerns/crud'
    autoload :Attributes,     'paymill/concerns/attributes'
    autoload :Persistence,    'paymill/concerns/persistence'
    autoload :LiveMode,       'paymill/concerns/live_mode'
  end
  
  class << self
    attr_accessor :api_key, :logger, :timeout

    def configure
      yield self
      self
    end
    
    def currency
      @currency ||= Money.default_currency
    end
    
    def currency=(value)
      @currency = Money::Currency.new(value)
    end
    
    def user_agent
      "paymill-ruby #{Paymill::VERSION}"
    end
    
    def environment
      ENV['RACK_ENV'] || 'development'
    end
    
    def log?
      environment == 'development' && !!logger
    end

    def request(method, path, payload={})
      Request.new(method, uri(path), payload).fetch
    end
    
    def uri(path=nil)
      URI::HTTPS.build(host: 'api.paymill.de', path: "/v2/#{path}")
    end   
  end
end