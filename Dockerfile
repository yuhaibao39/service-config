FROM docker.io/yuhaibao/java:8

VOLUME /tmp

ADD agent /agent

ADD target/*.jar app.jar


RUN bash -c 'touch /app.jar'
RUN bash -c 'touch /agent/skywalking-agent.jar'
RUN bash -c 'touch /agent/config/agent.config'

RUN bash -c 'ls /'

ARG DEAULT_OPTS='-javaagent:/agent/skywalking-agent.jar -Dskywalking_config=/agent/config/agent.config -Dskywalking.agent.service_name=fengce-service-config -Dskywalking.collector.backend_service=18.212.19.251:11800'
ENV JAVA_OPTS=$DEAULT_OPTS


ENTRYPOINT ["sh","-c","java -jar ${JAVA_OPTS} -Dfile.encoding=UTF-8 -Djava.security.egd=file:/dev/./urandom /app.jar"]
