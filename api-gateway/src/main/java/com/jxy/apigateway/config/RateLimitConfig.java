package com.jxy.apigateway.config;

import com.jxy.apigateway.key.UriKeyResolver;
import com.jxy.apigateway.key.IpKeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.PrincipalNameKeyResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import reactor.core.publisher.Mono;

import java.security.Key;
import java.util.Objects;

/**
 * @author wangkeyao
 */
@Configuration
public class RateLimitConfig {
    @Bean
    public KeyResolver uriKeyResolver() {
        return exchange -> Mono.just(exchange.getRequest().getPath().toString());
    }

    @Bean
    public KeyResolver ipKeyResolver() {
        return exchange -> Mono.just(Objects.requireNonNull(Objects.requireNonNull(exchange.getRequest().getRemoteAddress()).getHostName()));
    }

    @Bean
    public KeyResolver paramsKeyResolver() {
        return exchange -> Mono.just(Objects.requireNonNull(exchange.getRequest().getHeaders().getFirst("source")));
    }

    @Bean
    @Primary
    public PrincipalNameKeyResolver principalNameKeyResolver() {
        return new PrincipalNameKeyResolver();
    }

}
