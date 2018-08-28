FROM docker:18.06

WORKDIR /app

COPY ./*.sh /app/

ENTRYPOINT ["/bin/sh", "-c", "/app/prep.sh"]
