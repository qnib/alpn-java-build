FROM qnib/alpn-jdk8

ENV MAVEN_HOME=/usr/share/maven \
    MAVEN_VERSION=3.3.9
RUN cd /usr/share \
 && apk add --update protobuf \
 && rm -rf /var/cache/apk/* \
 && wget -q http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
 && apk add --update protobuf automake gcc libtool autoconf g++ zeromq-dev git make \
 && rm -rf /var/cache/apk/* \
 && cd /tmp/ \
 && git clone https://github.com/zeromq/jzmq.git \
 && cd jzmq/ \
 && git checkout v2.2.2 \
 && ./autogen.sh \
 && ./configure --prefix=/usr --with-zeromq=/usr \
 && make \
 && make install \
 && apk del automake gcc autoconf git make \
 && rm -rf /tmp/* /var/cache/apk/*

CMD ["mvn"]
