package balancefy.api.application.config.security;

import balancefy.api.resources.repositories.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

import java.util.Arrays;

@EnableWebSecurity
@Configuration
public class JWTConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private AutenticacaoService autenticacaoService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    @Bean
    protected AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(autenticacaoService).passwordEncoder(new BCryptPasswordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().configurationSource(request -> new CorsConfiguration().applyPermitDefaultValues())
                .and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and().csrf().disable().authorizeRequests()
                .antMatchers(HttpMethod.POST, "/api/auth").permitAll()
                .antMatchers(HttpMethod.POST, "/api/auth/**").permitAll()
                .antMatchers(HttpMethod.POST, "/api/users").permitAll()
                .antMatchers(HttpMethod.POST, "/api/accounts").permitAll()
                .antMatchers(HttpMethod.POST, "/api/accounts/goals/register/**").permitAll()
                .antMatchers(HttpMethod.GET, "/api/swagger-ui/**").permitAll()
                .antMatchers(HttpMethod.GET, "/api/swagger-ui.html").permitAll()
                .antMatchers(HttpMethod.GET, "/api/user-photos/**").permitAll()
                .antMatchers(HttpMethod.GET, "/api/v2/api-docs").permitAll()
                .antMatchers(HttpMethod.GET, "/api/transaction").permitAll()
                .antMatchers(HttpMethod.GET, "/api/goals").permitAll()
                .antMatchers(HttpMethod.POST, "/api/transactionFixed/account/**").permitAll()
                .anyRequest().authenticated()
                .and().addFilterBefore(new JWTValidarFilter(tokenService, usuarioRepository), UsernamePasswordAuthenticationFilter.class);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/**.html", "/api-docs", "/webjars/**", "/configuration/**", "/swagger-resources/**", "/**.yml");
    }
}
