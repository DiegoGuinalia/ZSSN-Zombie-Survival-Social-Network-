module Api
  module ResponseConcerns
    def body(result)
      if result.failure?
        body = { result: 'failed', error: result.error }
        return render json: body, :status => :unprocessable_entity
      end
      
      body = { result: 'success' }    
      render json: body
    end
  end
end
