module LoginHelper
  def login(user)
    client = "test"
    auth_headers = user.create_new_auth_token(client)
    request.headers.merge!(auth_headers)
  end
end
