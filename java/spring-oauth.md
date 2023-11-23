Enable `@EnableWebSecurity(debug = true)` at your Main class.

### Phase 0: Starting up
 - Register your OAuth App (client app) to the provider (e.g. https://github.com/settings/applications), then store the credentials in your confiurations files.
 - Read registration configurations of `providers registrations` (stored in confiurations files), load it to org.springframework.boot.autoconfigure.security.oauth2.client.servlet.OAuth2ClientRegistrationRepositoryConfiguration#clientRegistrationRepository
 - Build org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientPropertiesMapper#getClientRegistration
 - There are some common providers already integrated there (github, google, okta). Stored in CommonOAuth2Provider, loaded by org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientPropertiesMapper#getBuilder(...). That's why for some famous providers, you don't need to specify github provider details. See https://docs.spring.io/spring-security/reference/servlet/oauth2/login/core.html#oauth2login-custom-provider-properties
 - Finnaly, store in org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository#registrations
 

### Phase 1: Ask For Authorization code and state permission
 - Please see https://oauth.net/2/grant-types/authorization-code/
 - Visit homepage without any granted token from providers:
    - Enter Security Filter chain [...OAuth2AuthorizationRequestRedirectFilter...]
    - Do org.springframework.security.oauth2.client.web.OAuth2AuthorizationRequestRedirectFilter#doFilterInternal
    - Do org.springframework.security.oauth2.client.web.DefaultOAuth2AuthorizationRequestResolver#resolve(jakarta.servlet.http.HttpServletRequest)
    - Redirect to the `https://github.com/login/oauth/authorize?response_type=code&client_id=------&scope=read:user&state=-----&redirect_uri=http://localhost:8080/login/oauth2/code/github`
    - Wait for user to log-in into Github
    - Invoke org.springframework.security.oauth2.client.web.OAuth2AuthorizationRequestRedirectFilter#sendRedirectForAuthorization and saveAuthorizationRequest
 - With a already state and code:
  - 

### Phase 2: Do store Code and State and request resource using them
 - After we login to Github, it redirects back to our client app with the registered redirect url at `Phase 0` (e.g. `/login/oauth2/code/github?code=09ed63db80e290------&state=aNZEcIkTdglYs0wET1ATqOQLyU------26ZBIcP4%3D`)
 - Once again, the request enters Security Filter chain [...OAuth2AuthorizationRequestRedirectFilter...]
 - There may be more than one OAuth2AuthorizationRequestRedirectFilters (to check authorizationRequestMatcher, if the request is asking for login)
 - Invoke org.springframework.security.oauth2.client.endpoint.DefaultAuthorizationCodeTokenResponseClient#getTokenResponse to retrieve the `accessTokenResponse`
 - With `accessTokenResponse`, the client app now can fetch the granted data from the provider via org.springframework.security.oauth2.client.authentication.OAuth2LoginAuthenticationProvider#authenticate


### Phase 3: 
 - Enter 



### To read:
 - https://salesforce.stackexchange.com/questions/42445/whats-the-difference-between-these-authentication-endpoints
 - https://stackoverflow.com/questions/74683225/updating-to-spring-security-6-0-replacing-removed-and-deprecated-functionality
 - Disable CSRF to do logout in test env
