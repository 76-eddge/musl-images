FROM alpine AS build

# REMOVE Install vim
RUN apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache vim

# Install Powershell and its dependencies
RUN apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache ca-certificates less ncurses-terminfo-base krb5-libs libgcc libintl libssl1.1 libstdc++ tzdata userspace-rcu zlib icu-libs curl && apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust && curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.2.5/powershell-7.2.5-linux-alpine-x64.tar.gz -o /tmp/powershell.tar.gz && mkdir -p /opt/microsoft/powershell/7 && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 && chmod +x /opt/microsoft/powershell/7/pwsh && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh # buildkit

# Use Powershell for all future RUN commands
SHELL ["/usr/bin/pwsh", "-Command"]

# Grab non-Oracle OpenJDK
RUN Invoke-WebRequest 'https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.2%2B8/OpenJDK17U-jdk_x64_alpine-linux_hotspot_17.0.2_8.tar.gz' -OutFile '/tmp/jdk.tar.gz'; tar -xzf '/tmp/jdk.tar.gz' -C '/opt'; Remove-Item '/tmp/jdk.tar.gz'; New-Item -ItemType "file" -Path "$profile" -Force; Add-Content "$profile" '$env:PATH = "${env:PATH}:/opt/jdk-17.0.2+8/bin"'; Add-Content "$profile" '$env:JAVA_HOME = "/opt/jdk-17.0.2+8"'

# Grab Gradle
RUN Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-7.5.1-bin.zip' -OutFile '/tmp/gradle.zip'; Expand-Archive '/tmp/gradle.zip' '/opt'; Remove-Item '/tmp/gradle.zip'; Add-Content "$profile" '$env:PATH = "${env:PATH}:/opt/gradle-7.5.1/bin"'

# Other dependencies
RUN apk add --no-cache linux-headers musl-dev binutils file gcc g++ make libc-dev perl make git cmake patch sed util-linux-dev openssl llvm-dev clang doxygen libcrypto3 chromium ttf-freefont nodejs py3-setuptools py3-lxml py3-jinja2 python3 && ln -sf python3 /usr/bin/python

# Get npm
RUN pwsh -command apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/community add --no-cache npm

# Get ninja
RUN Invoke-WebRequest 'https://github.com/ninja-build/ninja/archive/refs/tags/v1.11.0.zip' -OutFile '/tmp/ninja.zip'; Expand-Archive '/tmp/ninja.zip' '/opt'; Remove-Item '/tmp/ninja.zip'; cd '/opt/ninja-*'; ./configure.py --bootstrap; Add-Content "$profile" '$env:PATH = "${env:PATH}:/opt/ninja-1.11.0"'

# erlang
RUN apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache erlang

# Grab our cross compilers
RUN Invoke-WebRequest 'https://github.com/76-eddge/musl-cross/releases/download/v0.9.11/x86_64-linux-musl.tar.xz' -OutFile '/tmp/x86_64-linux-musl.tar.xz'; New-Item -Path "/opt/x86_64-linux-musl" -ItemType "Directory" -Force; tar -xf "/tmp/x86_64-linux-musl.tar.xz" -C "/opt/x86_64-linux-musl"; # Remove-Item '/tmp/x86_64-linux-musl.tar.xz';\
Invoke-WebRequest 'https://github.com/76-eddge/musl-cross/releases/download/v0.9.11/aarch64-linux-musl.tar.xz' -OutFile '/tmp/aarch64-linux-musl.tar.xz'; New-Item -Path "/opt/aarch64-linux-musl" -ItemType "Directory" -Force; tar -xf "/tmp/aarch64-linux-musl.tar.xz" -C "/opt/aarch64-linux-musl"; Remove-Item '/tmp/aarch64-linux-musl.tar.xz';\
Invoke-WebRequest 'https://github.com/76-eddge/musl-cross/releases/download/v0.9.11/arm-linux-musleabihf.tar.xz' -OutFile '/tmp/arm-linux-musleabihf.tar.xz'; New-Item -Path "/opt/arm-linux-musleabihf" -ItemType "Directory" -Force; tar -xf "/tmp/arm-linux-musleabihf.tar.xz" -C "/opt/arm-linux-musleabihf"; Remove-Item '/tmp/arm-linux-musleabihf.tar.xz';\
Invoke-WebRequest 'https://github.com/76-eddge/musl-cross/releases/download/v0.9.11/i686-linux-musl.tar.xz' -OutFile '/tmp/i686-linux-musl.tar.xz'; New-Item -Path "/opt/i686-linux-musl" -ItemType "Directory" -Force; tar -xf "/tmp/i686-linux-musl.tar.xz" -C "/opt/i686-linux-musl"; Remove-Item '/tmp/i686-linux-musl.tar.xz';\
Invoke-WebRequest 'https://github.com/76-eddge/musl-cross/releases/download/v0.9.11/powerpc64le-linux-musl.tar.xz' -OutFile '/tmp/powerpc64le-linux-musl.tar.xz';  New-Item -Path "/opt/powerpc64le-linux-musl" -ItemType "Directory" -Force; tar -xf "/tmp/powerpc64le-linux-musl.tar.xz" -C "/opt/powerpc64le-linux-musl"; Remove-Item '/tmp/powerpc64le-linux-musl.tar.xz'

# COPY musl.tar /tmp

# RUN  tar -xf '/tmp/musl.tar' -C '/opt'; Remove-Item '/tmp/musl.tar'

# Get our Node dependencies
COPY "package.json" /home/

RUN cd /home/ && npm install && npm audit

# Grab local files

COPY setMuslLinux.ps1 /opt/scripts/setMuslLinux.ps1

COPY gradle /tmp/gradle

# Perform tasks as basic user
RUN adduser jenkins; chown -R jenkins /tmp/gradle

USER jenkins

RUN New-Item -ItemType "file" -Path "$profile" -Force; Add-Content "$profile" '$env:PATH = "${env:PATH}:/opt/gradle-7.5.1/bin/:/opt/jdk-17.0.2+8/bin:/opt/ninja-1.11.0"'; Add-Content "$profile" '$env:JAVA_HOME = "/opt/jdk-17.0.2+8"'; Add-Content "$profile" '$env:PUPPETEER_EXECUTABLE_PATH = "/usr/bin/chromium-browser"'

# Get our Gradle dependencies
RUN cd /tmp/gradle; gradle --no-daemon resolveDependencies



# COPY --chown=jenkins cpp2 /home/jenkins/cpp2

# COPY --chown=jenkins test /home/jenkins/test



# WORKDIR /home/jenkins/cpp2

# RUN /opt/scripts/setMuslLinux x86_64 && make && ./main