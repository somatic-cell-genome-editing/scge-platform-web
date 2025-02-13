package edu.mcw.scge.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;


import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;

import org.springframework.security.oauth2.client.endpoint.DefaultAuthorizationCodeTokenResponseClient;

import org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequest;

import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;

import org.springframework.security.oauth2.client.web.AuthorizationRequestRepository;
import org.springframework.security.oauth2.client.web.HttpSessionOAuth2AuthorizationRequestRepository;


import org.springframework.security.oauth2.core.endpoint.OAuth2AuthorizationRequest;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;



import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by jthota on 11/12/2019.
 */


@EnableWebSecurity
@PropertySource("classpath:application.properties")

public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
   public static final Boolean REQUIRE_AUTHENTICATION=false;
    public static final int GUEST_ACCOUNT_ID=1888;

    private static List<String> clients = Arrays.asList("google");


    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        List<ClientRegistration> registrations = clients.stream()
                .map(this::getRegistration)
                .filter(registration -> registration != null)
                .collect(Collectors.toList());

        return new InMemoryClientRegistrationRepository(registrations);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        if(System.getenv("HOSTNAME")!=null && System.getenv("HOSTNAME").equals("localhost")) {
            http.authorizeRequests().antMatchers("/**").permitAll();
        }else{
            http.authorizeRequests()
                    .antMatchers("/", "/home", "/logout", "/oauth_login", "/common/**", "/data/requestAccount", "/loginFailure",
                            "/images/**", "/css/**", "/js/**", "/forms_public/**", "/data/**", "/login.jsp").permitAll()
                    .anyRequest().authenticated()
                    .and()
                    .logout()
                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                    .logoutSuccessUrl("/")
                    .deleteCookies("JSESSIONID")
                    .invalidateHttpSession(true)
                    .permitAll()
                    .and()
                    .csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                    .and()
                    .oauth2Login()
                    .loginPage("/dashboard")
                    .permitAll()
                    .defaultSuccessUrl("/dashboard", true)
                    .failureUrl("/loginFailure")
                    .clientRegistrationRepository(clientRegistrationRepository())
                    .authorizedClientService(authorizedClientService())
                    .authorizationEndpoint()
                    .baseUri("/login")
                    .and()
                    .tokenEndpoint()
                    .accessTokenResponseClient(accessTokenResponseClient());

            http.headers().defaultsDisabled().cacheControl();
        }
    }
    @Bean
    public AuthenticationSuccessHandler successHandler(){
        return new SecurityHandler();
    }
    @Bean
    public OAuth2AuthorizedClientService authorizedClientService() {

        return new InMemoryOAuth2AuthorizedClientService(
                clientRegistrationRepository());
    }
    @Bean
    public AuthorizationRequestRepository<OAuth2AuthorizationRequest> authorizationRequestRepository() {
        return new HttpSessionOAuth2AuthorizationRequestRepository();
    }

    @Bean
    public OAuth2AccessTokenResponseClient<OAuth2AuthorizationCodeGrantRequest> accessTokenResponseClient() {
        return new DefaultAuthorizationCodeTokenResponseClient();
    }

    private static String CLIENT_PROPERTY_KEY
            = "spring.security.oauth2.client.registration.";

    @Autowired
    private Environment env;

    private ClientRegistration getRegistration(String client) {
        String clientId = env.getProperty(
                CLIENT_PROPERTY_KEY + client + ".client-id");

        if (clientId == null) {
            return null;
        }

        String clientSecret = env.getProperty(
                CLIENT_PROPERTY_KEY + client + ".client-secret");

        if (client.equals("google")) {
            return CommonOAuth2Provider.GOOGLE.getBuilder(client)
                    .clientId(clientId).clientSecret(clientSecret).build();
        }

        return null;
    }

    @Bean(name = "filterMultipartResolver")
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSize(100000000);
        return multipartResolver;
    }
}
