FROM cirrusci/flutter:stable

RUN yes | sdkmanager --licenses
RUN flutter config --enable-web

WORKDIR /app
