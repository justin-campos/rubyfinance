# OpenapiClient::UsersApi

All URIs are relative to *http://localhost:3000*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**users_get**](UsersApi.md#users_get) | **GET** /users | List users |


## users_get

> users_get

List users

### Examples

```ruby
require 'time'
require 'openapi_client'

api_instance = OpenapiClient::UsersApi.new

begin
  # List users
  api_instance.users_get
rescue OpenapiClient::ApiError => e
  puts "Error when calling UsersApi->users_get: #{e}"
end
```

#### Using the users_get_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> users_get_with_http_info

```ruby
begin
  # List users
  data, status_code, headers = api_instance.users_get_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue OpenapiClient::ApiError => e
  puts "Error when calling UsersApi->users_get_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined

