module OAuth2
  class AccessToken
    class << self
      def from_hash(client, hash)
        params = hash.dup
        token = params.delete('access_token') || params.delete(:access_token) || raise(ArgumentError, 'The hash did not contain an access_token')
        expires_at = params.delete('expires_at') || params.delete(:expires_at)
        expires_in = params.delete('expires_in') || params.delete(:expires_in)
        new(client, token, params.merge(expires_at ? { :expires_at => Time.at(expires_at) } : { :expires_in => expires_in }))
      end
    end
  end
end