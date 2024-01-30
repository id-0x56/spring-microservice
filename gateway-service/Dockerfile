FROM openjdk:19-jdk-alpine

ARG USERNAME=alpine
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN addgroup --system --gid $USER_GID $USERNAME \
    && adduser --system --uid $USER_UID --ingroup $USERNAME $USERNAME

ENV TZ=Europe/London
RUN apk add --no-cache tzdata \
    && rm -rf /var/cache/apk/* /var/tmp/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apk add --no-cache curl git

# maven
RUN curl --location https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip --output-dir /opt --create-dirs --remote-name \
    && unzip /opt/apache-maven-*-bin.zip -d /opt \
    && rm -rf /opt/apache-maven-*-bin.zip \
    && ln -s /opt/apache-maven-*/bin/mvn /usr/bin/mvn

# gradle
RUN curl --location https://services.gradle.org/distributions/gradle-8.5-bin.zip --output-dir /opt --create-dirs --remote-name \
    && unzip /opt/gradle-*-bin.zip -d /opt \
    && rm -rf /opt/gradle-*-bin.zip \
    && ln -s /opt/gradle-*/bin/gradle /usr/bin/gradle

RUN ls -la /opt \
    && ls -la /usr/bin/mvn \
    && ls -la /usr/bin/gradle

COPY . /var/www/java-app

COPY --chmod=755 docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "build/libs/rest-service.jar" ]



# docker login
# docker build --no-cache --tag 00x56/docker-openjdk:gateway .
# docker push 00x56/docker-openjdk:gateway

# docker run --rm --interactive --tty --volume .:/var/www/java-app --workdir /var/www/java-app --publish 8080:8080 00x56/docker-openjdk build/libs/rest-0.0.1-SNAPSHOT.jar
