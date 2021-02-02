 FROM swiftlang/swift:nightly-5.3-amazonlinux2
 RUN yum -y install git \
 jq \
 tar \
 zip
 WORKDIR /build-lambda
 RUN mkdir -p /Sources/SwiftDockerLambda/
 RUN mkdir -p /Tests/SwiftDockerLambda
 ADD /Sources/ ./Sources
 ADD /Tests/ ./Tests/
 COPY Package.swift .
 RUN cd /build-lambda && swift build -c release -Xswiftc -static-stdlib
 RUN mkdir -p /var/task/
 RUN cp .build/release/SwiftDockerLambda /var/task/SwiftDockerLambda
 WORKDIR /var/task
 RUN ln -s SwiftDockerLambda bootstrap
 RUN chmod 755 ./bootstrap
 RUN chmod 755 ./SwiftDockerLambda
 CMD ["/var/task/SwiftDockerLambda"]
