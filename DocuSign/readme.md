## DocuSign logs ingestion

## Deployment 
* [Protecting your DocuSign Agreements with Microsoft Sentinel](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/protecting-your-docusign-agreements-with-microsoft-sentinel/ba-p/2085502)
* [Ingest DocuSign Security Events](https://github.com/Azure/Azure-Sentinel/blob/master/DataConnectors/DocuSign-SecurityEvents/README.md)

## Possible errors

### 1. no_valid_keys_or_signatures (found in function app)

[DocuSign Support](https://support.docusign.com/s/articles/DocuSign-Developer-FAQs-General-Administration-and-Authentication?language=en_US#:~:text=no_valid_keys_or_signatures%3A%20This%20error%20covers%20several%20cases%3A)

When using JWT authentication, how do I troubleshoot an invalid_grant or other errors?
The invalid_grant error is a generic error response that means something is incorrect in the JWT assertion. In order to determine what is wrong, refer to the error_description parameter in the response. If the error_description isn't readily available in your application, we recommend setting up error logging that captures the full error response.

Authentication error responses:

consent_required: If using individual consent, make sure consent has been granted for the desired scopes. The signature impersonation scope is the minimum required for JWT authentication, but other scopes may be necessary for Rooms or Admin functions.
invalid_subject or user_not_found: Something is likely wrong with the sub (subject) value in the assertion. Confirm that the value is a valid GUID user ID (not an email address) of a user that is active in the relevant environment.
Issuer_not_found: The integration key in the iss (issuer) parameter is unavailable in the current environment. This can also mean a mismatch in the aud (audience) value and the environment being hit: for example, using an aud value of account.docusign.com while requesting a token from https://account-d.docusign.com/oauth/token.
no_valid_keys_or_signatures: This error covers several cases:
There is an issue with the private key used to sign the assertion (for example, using a demo key in the production environment).
The assertion is missing an exp (expiration) parameter
The aud (audience) parameter is invalid - confirm the audience value is exactly account.docusign.com or account-d.docusign.com with no https:// prefix or trailing slash (/).
An nbf (not valid before) parameter is defined, and that time has not been reached. The nbf parameter is optional and can be removed from the assertion, but if it is present, it must be a time in the past.
expired_grant: The assertion has expired. The exp (Expiration) parameter must be a time in the future.
