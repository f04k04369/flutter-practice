FROM cirrusci/flutter:stable

# Android SDK ライセンスを自動承認
RUN yes | sdkmanager --licenses

# Web対応を有効化
RUN flutter config --enable-web

WORKDIR /app
