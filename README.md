# Flutter + Docker + Firebase 開発環境（VSCode用）
このリポジトリは、Flutter開発を Docker + VSCode + Firebase で効率的に行うためのテンプレートです。

---
## ✅ 構成内容
flutter-docker-project/ ├── flutter/ ← Flutter SDK（GitHubからクローン） ├── flutter_project/ ← アプリプロジェクト ├── Dockerfile ← Flutter + Web + Firebase CLI環境 ├── .devcontainer/ ← VSCode用Remote Container設定 └── README.md ← このガイド

---
## 🧩 セットアップ手順
### ① Flutter SDKをローカルにクローン
```bash
git clone https://github.com/flutter/flutter.git
```
（必要であれば --branch stable を指定）

---
## ② VSCodeでプロジェクトを開く
VSCodeでこのプロジェクトフォルダを開く

コマンドパレットで Remote-Containers: Reopen in Container を実行

初回ビルドには数分かかります

---
## ③ Docker内でFlutter初期化
```bash
export PATH="$PATH:/app/flutter/bin"
flutter doctor
cd flutter_project
flutter create .
flutter run -d chrome
```
---
## 🔥 Firebaseとの連携（必要な方のみ）
1. Firebase CLIログイン（必要に応じて）
```bash
firebase login
```
2. FlutterFire CLI初期化
```bash
flutterfire configure
```
---
## 📦 その他コマンド
* flutter build apk：Androidビルド
* flutter build web：Webビルド
---
## ✅ 注意点
* iOSシミュレータやXcodeビルドはmacOSホスト側で実行してください
* Docker内からAndroidエミュレータを操作する場合は、adb connect が必要です
---
## ✅ 推奨構成
* VSCode + Remote Containers 拡張機能
* Docker Desktop（Linux or macOS or WSL2）
* Android Studio（AVD利用のため）
---
## 🧑‍💻 作成者
このテンプレートはFlutter/Docker連携を最小コストで実現するために設計されています。
```yaml

## ✅ Dockerfile の微修正（必要な場合）

`flutter/bin` が `/app/flutter/bin` にある前提なので、  
Dockerfileの中で PATH を追加しておくと便利です：

```dockerfile
ENV PATH="/app/flutter/bin:${PATH}"

```
---
## ✅ まとめ
* Flutter SDKを flutter/ にクローンする構成、大正解です 💯
* それに合わせて README.md を構成済み
* 必要であれば .bashrc に PATH=/app/flutter/bin を追記もOK