package edu.mcw.scge.configuration;

import edu.mcw.scge.services.SCGEContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.oauth2.client.CommonOAuth2Provider;


import org.springframework.security.oauth2.client.InMemoryOAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;


import org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequest;

import org.springframework.security.oauth2.client.endpoint.RestClientAuthorizationCodeTokenResponseClient;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;

import org.springframework.security.oauth2.client.web.AuthenticatedPrincipalOAuth2AuthorizedClientRepository;


import org.springframework.security.oauth2.client.web.OAuth2AuthorizedClientRepository;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.servlet.util.matcher.PathPatternRequestMatcher;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;


import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Created by jthota on 11/12/2019.
 */

@Configuration
@EnableWebSecurity
@PropertySource("classpath:application.properties")

public class SecurityConfiguration {

    private static String CLIENT_PROPERTY_KEY = "spring.security.oauth2.client.registration.";
    @Autowired
    private Environment env;
    private static List<String> clients = Arrays.asList("google");


//    @Bean
//    public ClientRegistrationRepository clientRegistrationRepository() {
//        List<ClientRegistration> registrations = clients.stream()
//                .map(this::getRegistration)
//                .filter(registration -> registration != null)
//                .collect(Collectors.toList());
//
//        return new InMemoryClientRegistrationRepository(registrations);
//    }

//    @Override
//    protected void configure(HttpSecurity http) throws Exception {
//        if(System.getenv("HOSTNAME")!=null && System.getenv("HOSTNAME").equals("localhost")) {
//            http.authorizeRequests().requestMatchers("/**").permitAll();
//        }else{
//            http.authorizeRequests()
//                    .requestMatchers("/", "/home", "/logout", "/oauth_login", "/common/**", "/data/requestAccount", "/loginFailure",
//                            "/images/**", "/css/**", "/js/**", "/forms_public/**", "/data/**", "/login.jsp").permitAll()
//                    .anyRequest().authenticated()
//                    .and()
//                    .logout()
//                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
//                    .logoutSuccessUrl("/")
//                    .deleteCookies("JSESSIONID")
//                    .invalidateHttpSession(true)
//                    .permitAll()
//                    .and()
//                    .csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
//                    .and()
//                    .oauth2Login()
//                    .loginPage("/dashboard")
//                    .permitAll()
//                    .defaultSuccessUrl("/dashboard", true)
//                    .failureUrl("/loginFailure")
//                    .clientRegistrationRepository(clientRegistrationRepository())
//                    .authorizedClientService(authorizedClientService())
//                    .authorizationEndpoint()
//                    .baseUri("/login")
//                    .and()
//                    .tokenEndpoint()
//                    .accessTokenResponseClient(accessTokenResponseClient());
//
//            http.headers().defaultsDisabled().cacheControl();
//        }
//    }
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//    if(System.getenv("HOSTNAME")!=null && System.getenv("HOSTNAME").equals("localhost")) {
//   //  if(!SCGEContext.isProduction() && !SCGEContext.isTest() && !SCGEContext.isDev()){
//            http.authorizeHttpRequests(authorize->
//                    authorize.requestMatchers("/**")
//                            .permitAll());
//    }else {
        http.authorizeHttpRequests(authorize -> authorize.requestMatchers("/", "/home", "/logout", "/oauth_login", "/common/**", "/data/requestAccount", "/loginFailure",
                        "/images/**", "/css/**", "/js/**", "/forms_public/**", "/data/**", "/login.jsp", "/login")
                .permitAll()
                .anyRequest().authenticated());

               http. oauth2Login(auth2 -> auth2
                    .loginPage("/dashboard").permitAll()
                    .failureUrl("/loginFailure")
                    .defaultSuccessUrl("/dashboard", true)
                    .clientRegistrationRepository(clientRegistrationRepository())
                    .authorizedClientService(authorizedClientService(clientRegistrationRepository()))
                    .authorizationEndpoint(authorization -> authorization.baseUri("/login"))
                    .tokenEndpoint(tokenEndpointConfig -> tokenEndpointConfig.accessTokenResponseClient(accessTokenResponseClient())))
            .logout(logout -> logout
                    .logoutRequestMatcher(PathPatternRequestMatcher.withDefaults().matcher("/logout"))
                    .logoutSuccessUrl("/") // Redirect after logout
                    .invalidateHttpSession(true) // Invalidate the session
                    .deleteCookies("JSESSIONID") // Delete cookies
            ).csrf(csrf -> csrf.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()));

    http.headers(headers -> headers.cacheControl(HeadersConfigurer.CacheControlConfig::disable));
//    }
    return http.build();
}

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        List<ClientRegistration> registrations = clients.stream()
                .map(this::getRegistration)
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        return new InMemoryClientRegistrationRepository(registrations);
    }

    private ClientRegistration getRegistration(String client) {
        String clientId = env.getProperty(
                CLIENT_PROPERTY_KEY + client + ".client-id");

        String clientSecret = env.getProperty(
                CLIENT_PROPERTY_KEY + client + ".client-secret");

        if (client.equals("google")) {
            return CommonOAuth2Provider.GOOGLE.getBuilder(client)
                    .clientId(clientId).clientSecret(clientSecret).build();
        }

        return null;
    }
    @Bean
    public OAuth2AuthorizedClientService authorizedClientService(
            ClientRegistrationRepository clientRegistrationRepository) {
        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository);
    }

    @Bean
    public OAuth2AuthorizedClientRepository authorizedClientRepository(
            OAuth2AuthorizedClientService authorizedClientService) {
        return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService);
    }
    @Bean
    public OAuth2AccessTokenResponseClient<OAuth2AuthorizationCodeGrantRequest> accessTokenResponseClient() {
        return new RestClientAuthorizationCodeTokenResponseClient();
    }
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

//    @Bean
//    public AuthenticationSuccessHandler successHandler(){
//        return new SecurityHandler();
//    }
//    @Bean
//    public OAuth2AuthorizedClientService authorizedClientService() {
//
//        return new InMemoryOAuth2AuthorizedClientService(
//                clientRegistrationRepository());
//    }
//    @Bean
//    public AuthorizationRequestRepository<OAuth2AuthorizationRequest> authorizationRequestRepository() {
//        return new HttpSessionOAuth2AuthorizationRequestRepository();
//    }
//
//


//    private ClientRegistration getRegistration(String client) {
//        String clientId = env.getProperty(
//                CLIENT_PROPERTY_KEY + client + ".client-id");
//
//        if (clientId == null) {
//            return null;
//        }
//
//        String clientSecret = env.getProperty(
//                CLIENT_PROPERTY_KEY + client + ".client-secret");
//
//        if (client.equals("google")) {
//            return CommonOAuth2Provider.GOOGLE.getBuilder(client)
//                    .clientId(clientId).clientSecret(clientSecret).build();
//        }
//
//        return null;
//    }

//    @Bean(name = "filterMultipartResolver")
//    public CommonsMultipartResolver multipartResolver() {
//        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
//        multipartResolver.setMaxUploadSize(100000000);
//        return multipartResolver;
//    }
@Bean(name = "mvcHandlerMappingIntrospector")
public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
    return new HandlerMappingIntrospector();
}
}
