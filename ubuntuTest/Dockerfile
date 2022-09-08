FROM ubuntu AS build


RUN apt-get update

RUN apt-get install -y uuid-dev build-essential

RUN adduser jenkins

USER jenkins

# # Grab Gradle
# RUN Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-7.5.1-bin.zip' -OutFile '/tmp/gradle.zip'; Expand-Archive '/tmp/gradle.zip' '/opt'; Remove-Item '/tmp/gradle.zip'; Add-Content "$profile" '$env:PATH = "${env:PATH}:/opt/gradle-7.5.1/bin"'

# # Other dependencies

# RUN apt-get install -y binutils file build-essential libc-dbg vim uuid-dev gdb perl git cmake patch sed util-linux openssl clang doxygen nodejs npm erlang gradle openjdk-17-jdk python3-setuptools python3-lxml python3-jinja2 python3 && ln -sf python3 /usr/bin/python

# # Get npm
# RUN pwsh -command apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/community add --no-cache npm

# Get ninja

# COPY gradle /tmp/gradle

# # Perform tasks as basic user
# RUN adduser -D jenkins; chown -R jenkins /tmp/gradle

# USER jenkins

# COPY --chown=jenkins cpp2 /home/jenkins/cpp2

# # COPY --chown=jenkins test /home/jenkins/test

# RUN New-Item -ItemType "file" -Path "$profile" -Force; Add-Content "$profile"; Add-Content "$profile" '$env:NODE_PATH = "/usr/local/lib/node_modules"';

# # Get our Gradle dependencies
# RUN cd /tmp/gradle; gradle --no-daemon resolveDependencies

# WORKDIR /home/jenkins/cpp2

# # RUN /opt/scripts/setMuslLinux x86_64 && make && ./main
