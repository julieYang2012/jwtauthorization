package ca.xenex.JwtAuthorization.config;

import java.io.InputStream;
import java.security.KeyPair;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.UnrecoverableKeyException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KeyStoreConfiguration {
	
	@Value("${security.jwt.key-store-file}")
	private String KEY_STORE_FILE;
	
	@Value("${security.jwt.key-store-type}")
	private String KEY_STORE_TYPE;
	
    @Value("${security.jwt.key-store-password}")
	private String KEY_STORE_PASSWORD;
    
    @Value("${security.jwt.key-store-alias}")
    private String ALIAS;

    private KeyStore keyStore;

    @PostConstruct
    public void init() {
        try {
        	String keyStoreFileName = "/"+ KEY_STORE_FILE;
        	
            keyStore = KeyStore.getInstance(KEY_STORE_TYPE);
            
            InputStream resourceAsStream = getClass().getResourceAsStream(keyStoreFileName);
            
            keyStore.load(resourceAsStream, KEY_STORE_PASSWORD.toCharArray());
        } catch (Exception e) {
        }
    }
    
    
	@Bean
    public KeyPair keyPair() throws UnrecoverableKeyException, KeyStoreException, NoSuchAlgorithmException {
		PrivateKey privateKey = (PrivateKey) keyStore.getKey(ALIAS, KEY_STORE_PASSWORD.toCharArray());
		PublicKey publicKey = (PublicKey) keyStore.getCertificate(ALIAS).getPublicKey();
		return new KeyPair(publicKey, privateKey);
    }

}
