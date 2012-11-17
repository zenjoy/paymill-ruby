module Paymill
  class Payment < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-directdebit

    def self.build(attrs={})
      case attrs['type'] || attrs[:type]
        when 'creditcard' then CreditCard.new(attrs)
        when 'debit'      then DirectDebit.new(attrs)
      end
    end

    attr_accessor :type, :client
    
    def number(opts={})
      p = opts.fetch(:placeholder, "\u2022")
      s = opts.fetch(:separator, "-")
      last4.to_s.rjust(16, p).scan(/.{1,4}/m).join(s)
    end
  end
end