# Define parameter values
$tenantId = "<your tenant id>"  # Replace with your actual tenant ID
$clientId = "<client id>"
$clientSecret = "<client secret>"  # Replace with your actual client secret
$scope = "https://management.azure.com/.default"
$grantType = "client_credentials"
# Prepare the request body
$body = @{
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = $scope
    grant_type    = $grantType
} 
# Prepare the request URL
$url = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
# Send the POST request
$response = Invoke-RestMethod -Method Post -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body
# Extract the access_token
$accessToken = $response.access_token
# Copy the access_token to the clipboard
Set-Clipboard -Value $accessToken
# Output a confirmation message
Write-Output "The access token has been copied to the clipboard."
# Output the response (optional, for debugging purposes)
$response
