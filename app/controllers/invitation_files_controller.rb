class InvitationFilesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    def create
        binding.pry
        blob = ActiveStorage::Blob.create_before_direct_upload!(blob_params)
        render json: direct_upload_json(blob)
    end
    
    private
    
    def blob_params
        params.require(:blob).permit(:filename, :byte_size, :checksum, :content_type, metadata: {})
    end

    def direct_upload_json(blob)
        blob.as_json(root: false, methods: :signed_id).merge(
          direct_upload: {
            url: blob.service_url_for_direct_upload,
            headers: blob.service_headers_for_direct_upload
          }
        )
    end
end 