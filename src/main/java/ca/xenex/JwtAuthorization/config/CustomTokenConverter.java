package ca.xenex.JwtAuthorization.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;

public class CustomTokenConverter extends JwtAccessTokenConverter {

	@Value("${security.jwt.issuer}")
	private String ISSUER;
	
    @Override
    public OAuth2AccessToken enhance(OAuth2AccessToken accessToken,
            OAuth2Authentication authentication) {
    	// Enhance access token to add iss (The JWT issuer) parameter to JWT payload , The resource server is validating that value with its "issuer-uri" value during the authentication process 
    	final Map<String, Object> additionalInfo = new HashMap<String, Object>();

        additionalInfo.put("iss", ISSUER);

        ((DefaultOAuth2AccessToken) accessToken)
                .setAdditionalInformation(additionalInfo);
        
        accessToken = super.enhance(accessToken, authentication);
        ((DefaultOAuth2AccessToken) accessToken).setAdditionalInformation(new HashMap<>());
        return accessToken;
    }
}