require 'aws-sdk-s3'

s3  = Aws.config.update({
 region: Rails.application.credentials.dig(:aws_s3, :region),
 credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws_s3, :access_key_id),  Rails.application.credentials.dig(:aws_s3, :secret_access_key)),
})