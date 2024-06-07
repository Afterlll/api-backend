package com.jxy.apigateway.filter;

import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
public class IgnoreGlobalFilter extends AbstractGatewayFilterFactory<IgnoreGlobalFilter.Config> {

    public IgnoreGlobalFilter() {
        super(Config.class);
    }

    @Override
    public GatewayFilter apply(Config config) {
        return this::filter;
    }

    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        exchange.getAttributes().put(CustomGlobalFilter.ATTRIBUTE_IGNORE_CUSTOM_GLOBAL_FILTER, true);
        return chain.filter(exchange);
    }

    public static class Config {

    }

    @Override
    public String name() {
        return "IgnoreGlobalFilter";
    }

}