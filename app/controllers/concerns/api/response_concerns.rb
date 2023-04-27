module Api
  module ResponseConcerns
    def body(result, body_data = nil)
      if result.failure?
        body = { result: 'failed', error: result.error }
        return render json: body, :status => :unprocessable_entity
      end
      
      body = { result: body_data || 'success' }    
      render json: body
    end
  end
end
