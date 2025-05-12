Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://todo-front-xtr4.vercel.app'
      resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete, :options],
        expose: ['Access-Control-Allow-Origin']
    end
end