unless AWS_SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY']
  raise "Please set the AWS_SECRET_ACCESS_KEY environment variable"
end

unless AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID']
  raise "Please set the AWS_ACCESS_KEY_ID environment variable"
end

unless AWS_S3_HOST = ENV['AWS_S3_HOST']
  raise "Please set the AWS_S3_HOST environment variable"
end

unless AWS_S3_BUCKET = ENV['AWS_S3_BUCKET']
  raise "Please set the AWS_S3_BUCKET environment variable"
end
