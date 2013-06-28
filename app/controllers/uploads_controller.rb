# encoding: utf-8

class UploadsController < ApplicationController
  def new
  end

  private

  def uploads_directory; '/uploads/'; end

  def policy_attributes
    {
      "expiration" => 20.minutes.from_now.utc.xmlschema,
      "conditions" =>  [
        { 'bucket' =>  AWS_S3_BUCKET },
        [ 'starts-with', '$key', uploads_directory ],
        { 'acl' => acl },
        { 'success_action_status' => success_action_status },
        { 'utf8' => '✓' }
      ]
    }
  end

  def s3_host; "http://#{AWS_S3_BUCKET}.#{AWS_S3_HOST}"; end
  helper_method :s3_host

  def key; "#{uploads_directory}${filename}"; end
  helper_method :key

  def aws_access_key_id; AWS_ACCESS_KEY_ID; end
  helper_method :aws_access_key_id

  def acl; 'private'; end
  helper_method :acl

  def success_action_status; '201'; end
  helper_method :success_action_status

  def policy
    @policy ||= Base64.encode64(policy_attributes.to_json).gsub(/\n/, '')
  end
  helper_method :policy

  def signature
    @signature ||= Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        AWS_SECRET_ACCESS_KEY,
        policy
      )
    ).gsub("\n", "")
  end
  helper_method :signature
end