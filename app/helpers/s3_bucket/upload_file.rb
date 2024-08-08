class UploadFile 
   
    def upload_file(file_path)
        s3 = Aws::S3::Resource.new(
                endpoint: Rails.application.credentials.aws_s3[:endpoint],
                region: Rails.application.credentials.aws_s3[:region],
                access_key_id: Rails.application.credentials.aws_s3[:access_key_id],
                secret_access_key: Rails.application.credentials.aws_s3[:secret_access_key]
                )

        file_name = file_path.split('/').last
        obj = s3.bucket(Rails.application.credentials.aws_s3[:bucket]).object(SecureRandom.hex + "/" + file_name)
            
        upload_params = {acl: 'public-read'}
        upload_params[:content_disposition] = "attachment" 
        obj.upload_file(file_path.to_s, upload_params)
    
        return {
            uploaded_file_path: obj.public_url
        }
    end
  end
  