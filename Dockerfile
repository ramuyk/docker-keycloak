FROM quay.io/keycloak/keycloak:23.0.1 as builder
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=false
ENV KC_FEATURES=token-exchange,recovery-codes
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:23.0.1
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
ENV KC_DB_URL=jdbc:postgresql://db/keycloak
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=${PG_PASSWORD}
ENV KC_HOSTNAME=${KC_HOSTNAME}
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized", "--proxy=edge"]

