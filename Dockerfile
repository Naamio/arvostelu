FROM ibmcom/swift-ubuntu-runtime:4.0

ADD .build/release/ /usr/share/arvostelu/

ENV ARVOSTELU_SERVICE_PORT=8000
ENV LOG=INFO

EXPOSE ${ARVOSTELU_SERVICE_PORT}

WORKDIR /usr/share/arvostelu/

ENTRYPOINT ["/usr/share/arvostelu/Arvostelu"]
