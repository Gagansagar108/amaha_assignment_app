class FilesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    def create
        blob_params =  blob_params()
       
        blob = ActiveStorage::Blob.create_before_direct_upload!(
            filename: blob_params[:filename],
            byte_size: blob_params[:byte_size],
            checksum: blob_params[:checksum],
            content_type: blob_params[:content_type],
            metadata: blob_params[:metadata]
          )
        render json: direct_upload_json(blob)
    end

    private
    
    def blob_params
        params.require(:blob).permit(:filename, :byte_size, :checksum, :content_type, metadata: {})
    end

    def direct_upload_json(blob)
        binding.pry
        url = blob.service_url_for_direct_upload(expires_in: 15.minutes)
        blob.as_json(root: false, methods: :signed_id).merge(
          direct_upload: {
            url: url,
            headers: blob.service_headers_for_direct_upload
          }
        )
        blob.update_attribute(:key_url, url)
    end
end 