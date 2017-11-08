Rails.configuration.stripe = {
  :publishable_key => 'pk_test_qinMweoK9ezDvq3edLuk7J0K',
  :secret_key      => 'sk_test_4zvhuXXLGLu8lgP8GQl11etx'

}

Stripe.api_key = Rails.configuration.stripe[:secret_key]