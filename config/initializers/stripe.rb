Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'] || 'pk_test_51RP9eS8Bw7Qpqt9zy7LWhI054t3xuTIoGazRVQDL2pniSnor5QrF2HOqZrFWZ2o0eq5n1wlT86lDf5ZEXIxICE8Y00LquMQ6VP',
  secret_key: ENV['STRIPE_SECRET_KEY'] || 'sk_test_51RP9eS8Bw7Qpqt9z3SeKZOll4li6pEJcBU1HK5myfjAyeXxWJSA09PXU9hej5lt4Sip5mKHXRYXmJIr6yXRxiTGX00ftdo6XGY'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
