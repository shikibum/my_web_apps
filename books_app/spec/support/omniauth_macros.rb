# frozen_string_literal: true

module OmniauthMacros
  def twitter_mock
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: 1234,
      info: {
        name: 'kawauso',
        email: 'super@otter.com',
        image: 'http://pbs.twimg.com/profile_images/1013639049427369985/JQSGaobZ_normal.jpg'
      }
    )
  end
end
