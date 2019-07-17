require "pseg_recurring/version"
require "pseg_recurring/session"
require "pseg_recurring/plan"
require "pseg_recurring/order"
require "pseg_recurring/subscription"
require "pseg_recurring/notification"
require "pseg_recurring/error"
require "pseg_recurring/utils/error/errors_recurring_payment"
require "pseg_recurring/utils/error/errors_checkout_payment"

module PsegRecurring
  class Fire
    
    # Set the global configuration.
    # FIXME: send credentials to initialize;
    def initialize
      @credentials = {
        :email => "xxx@xxx.xx",
        :token => "ABCDE12345",
        :environment => uris.fetch(:sandbox.to_sym)
      }
    end

    # Get session ID
    def get_session_id
      PsegRecurring::Session.new(@credentials).session_id
    end

    # Create a new plan
    def create_plan(plan)
      PsegRecurring::Plan.new(@credentials).send_plan(plan)
    end

    # Create a new subscription
    def create_subscription(sender)
      PsegRecurring::Subscription.new(@credentials).send_subscription(sender)
    end

    # Cancel a subscription
    def cancel_subscription(code)
      PsegRecurring::Subscription.new(@credentials).send_subscription_cancel(code)
    end
    
    # Set discount in next order
    def set_discount_next_order(discount, code)
      PsegRecurring::Order.new(@credentials).send_discount(discount, code)
    end

    # Get orders by preapproval code
    def list_orders(code)
      PsegRecurring::Order.new(@credentials).fetch_orders(code)
    end

    # Receive pagseguro notification
    def notification(notification_code, notification_type)
      PsegRecurring::Notification.new(@credentials).receive(notification_code, notification_type)
    end

    private
      def uris
        @uris ||= {
          production: "https://ws.pagseguro.uol.com.br",
          sandbox: "https://ws.sandbox.pagseguro.uol.com.br"
        }
      end

  end
end
