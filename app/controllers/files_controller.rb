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

        response = direct_upload_json(blob)
        
        update_file_url(response)

        render json: 
    end

    private
    
    def blob_params
        params.require(:blob).permit(:filename, :byte_size, :checksum, :content_type, metadata: {})
    end

    def direct_upload_json(blob)
        url = blob.service_url_for_direct_upload(expires_in: 15.minutes)
        
        blob.as_json(root: false, methods: :signed_id).merge(
          direct_upload: {
            url: url,
            headers: blob.service_headers_for_direct_upload
          }
        )
    end

    def update_file_url(response)
      file_url = eval("response[:direct_upload].to_h[:url].split(response[:key]).first+response[:key]")
      blob.update_attribute(:file_url, file_url)
    end 
end 