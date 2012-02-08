Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '312978772087008', 'e20888841eed2489f95b1cb3b39b8b2e'
end