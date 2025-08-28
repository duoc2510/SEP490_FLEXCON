package config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;

import java.util.Arrays;

@Configuration
@PropertySource("classpath:application.properties")
public class OAuth2ClientConfig {

    // Needed for @Value to resolve placeholders when NOT using Spring Boot
    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
        return new PropertySourcesPlaceholderConfigurer();
    }

    @Bean
    public ClientRegistration googleClientRegistration(@Value("${oauth2.google.client-id}") String clientId, @Value("${oauth2.google.client-secret}") String clientSecret, @Value("${oauth2.google.redirect-uri}") String redirectUri, @Value("${oauth2.google.scopes:openid,profile,email}") String scopesCsv) {
        String[] scopes = Arrays.stream(scopesCsv.split(",")).map(String::trim).filter(s -> !s.isEmpty()).toArray(String[]::new);

        return CommonOAuth2Provider.GOOGLE.getBuilder("google").clientId(clientId).clientSecret(clientSecret).redirectUri(redirectUri).scope(scopes).build();
    }

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository(ClientRegistration googleClientRegistration) {
        return new InMemoryClientRegistrationRepository(googleClientRegistration);
    }

    @Bean
    public OAuth2AuthorizedClientService authorizedClientService(ClientRegistrationRepository repo) {
        return new InMemoryOAuth2AuthorizedClientService(repo);
    }
}
