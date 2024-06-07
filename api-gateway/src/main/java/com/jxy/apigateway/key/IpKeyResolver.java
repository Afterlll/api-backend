package com.jxy.apigateway.key;

import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Objects;

/**
 * IP限流
 */
public class IpKeyResolver implements KeyResolver {

    public static final String BEAN_NAME = "ipKeyResolver";

    @Override
    public Mono<String> resolve(ServerWebExchange exchange) {
        return Mono.just(Objects.requireNonNull(Objects.requireNonNull(exchange.getRequest().getRemoteAddress()).getHostName()));
    }
}

