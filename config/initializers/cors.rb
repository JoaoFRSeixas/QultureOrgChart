Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'   # pode restringir para 'http://localhost:3001' depois
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
