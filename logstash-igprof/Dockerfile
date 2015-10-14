FROM logstash

RUN mkdir -p /opt/logstash/patterns/igprof-io/
ADD igprof-io-patterns.conf /opt/logstash/patterns/igprof-io/
ADD logstash.conf /

CMD logstash -f /logstash.conf
