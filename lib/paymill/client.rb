module Paymill
  class Client < Resource
    # https://www.paymill.com/de-de/dokumentation/referenz/api-referenz/index.html#document-clients


    # email:        String or null -> Mail address of this client
    # description:  String or null -> Additional description for this client, perhaps the identifier from your CRM system?
    # payment:      List -> creditcard-object or directdebit-object
    # subscription: Hash or null -> subscriptions-object
    
    attr_accessor :email, :description, :subscription, :payment

#     def subscriptions
#       read_array_attribute(:subscription, Subscription)
#     end
#     
#     def payments
#       read_array_attribute(:payment, Payment)
#     end

    def subscribe!(offer_id, payment_id=nil)
      Subscription.create({ client: id, offer: offer_id, payment: payment_id })
    end
  end
end