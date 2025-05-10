# Flutter 開発テンプレート（Android Studio + Docker 対応）
このリポジトリは、Flutterを使ってWeb／モバイルアプリを開発するための、再現性・チーム共有性の高いテンプレートです。
初心者でも安心して始められるように、「Docker開発」と「Android Studioでの実機テスト」の両方に対応しています。
## ✅ このテンプレートでできること
| 機能                       | 説明                                                                 |
|----------------------------|----------------------------------------------------------------------|
| 💻 Android Studioでの実機デバッグ | 実機またはエミュレータでFlutterアプリを即テストできます                                      |
| 🐳 Dockerでのビルド環境       | チーム全員が同じビルド環境でFlutter開発ができます（CI/CDに最適）                               |
| 🌐 Webアプリ対応             | WebビルドやChrome実行も可能です（ホストでFlutterを使う場合）                                  |
| 🔥 Firebase連携             | Firebase Authentication, Firestore, Cloud FunctionsなどをFlutterFireで簡単に接続可能です |
---
## 🧰 必要なツール（インストール推奨）
| ツール              | 用途                                | リンク                                              |
|---------------------|-------------------------------------|------------------------------------------------------|
| Docker Desktop      | ビルド環境共有・自動化用             | https://www.docker.com/products/docker-desktop       |
| VS Code             | エディター＋Remote Container対応     | https://code.visualstudio.com/                       |
| Android Studio      | 実機／エミュレータデバッグ用         | https://developer.android.com/studio                |
| Flutter SDK         | ホストOSでWeb開発やChrome実行時に使用 | https://docs.flutter.dev/get-started/install        |
| Firebase CLI（任意） | Firebaseと連携する場合               | https://firebase.google.com/docs/cli                 |
## Android Studioでの開発手順（推奨）

## ✅ 構成内容
```pgsql
flutter-docker-project/
├── flutter_project/          ← アプリ本体
├── Dockerfile                ← Flutter SDK含むイメージ
├── .devcontainer/            ← VSCode Remote用設定（任意）
│   └── devcontainer.json
└── README.md                 ← このガイド
```
---
## 🚀 Android Studioでの開発手順
1. Android Studioで `flutter_project/` を開く  
2. 実機またはAVDを起動  
3. 下記コマンドでテスト実行：
```bash
flutter run -d android-xxxxx
```
4. web確認なら
```bash
flutter run -d chrome
```
`※flutter devicesでデバイス一覧を確認できます。`

---
## 🐳 Dockerでのビルド手順（任意）
❗ 事前に Docker Desktop をインストール
### ① Dockerで開発環境を起動（VSCode）
1. VSCodeでこのプロジェクトを開く
2. コマンドパレット（F1）で Remote-Containers: Reopen in Container を選択
3. Docker環境が立ち上がります（初回は時間がかかる）
### ② ビルドしてAPKを作成：
```bash
cd flutter_project
flutter build apk
```
### ③ Webアプリをビルド：
```bash
flutter build web
```
---
## 🔥 Firebase連携（必要な場合）
1. Firebase CLIをインストール
```bash
npm install -g firebase-tools
firebase login
```
2. FlutterFire CLIで初期設定
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
`これにより firebase_options.dart が自動生成されます`

---
## 🧼 よく使うFlutterコマンド
| コマンド                         | 説明                                     |
|----------------------------------|------------------------------------------|
| `flutter run`                    | アプリを指定デバイスで起動               |
| `flutter devices`                | 接続中の実機・AVD一覧を表示              |
| `flutter build apk`              | Android用APKをビルド                     |
| `flutter build web`              | Web用にHTMLをビルド                      |
| `flutter clean`                  | キャッシュ削除（ビルドエラー時に有効）  |
---
## 補足メモ
* .env などの秘密情報は .gitignore で除外するようにしてください
* iOSビルドは macOS + Xcode 環境が必須です（DockerやWindowsでは不可）
* Firebase Authentication を使う場合、Googleログインや匿名ログインの有効化を忘れずに！
---
## 🙋 よくある質問
Q. flutter run -d chrome がDockerで動きません
→ DockerではChromeなどGUIアプリが起動できません。ホストOSのFlutterから実行してください。  
Q. ADB経由で実機に接続できません  
→ Android Studioで開いて、USB接続 or Wi-Fiデバッグで対応すると最も安定します。  
Q. Flutter SDKがないとビルドできませんか？
→ Docker側に含まれているので、VSCode + DockerならFlutterのローカルインストールは不要です。

---
## 🎯 開発推奨スタイルまとめ
| 機能             | 開発場所         | 備考                                     |
|------------------|------------------|------------------------------------------|
| コーディング       | VSCode / Android Studio | 双方可・共有ディレクトリが前提           |
| 実機テスト         | Android Studio    | 実機 or AVD で `flutter run`            |
| Web実行           | ホストOS（Flutter CLI）| Dockerでは実行不可                      |
| ビルド            | Docker            | 本番APKやWebビルドに最適                |
---
## 🧑‍💻 この構成の利点
* 実機テストと再現性の高いCIビルドを分離
* Firebase対応も含むプロジェクト
* チーム開発・自動化にも展開しやすい
---
お気軽にForkしてご利用ください！🚀
```yaml

---

## ✅ GitHub にあげるファイル構成（要 push）

| ファイル / フォルダ         | 説明 |
|----------------------------|------|
| `flutter_project/`         | `flutter create` で作成された本体ディレクトリ |
| `Dockerfile`               | Flutter SDK + build 用（後述） |
| `.devcontainer/`（任意）   | Docker + VSCode連携用 |
| `README.md`                | 上記の完全版 |

---

## ✅ Dockerfile（本番ビルド向け）

```dockerfile
FROM cirrusci/flutter:stable

# Android SDKライセンス自動承認
RUN yes | sdkmanager --licenses

# Web対応（任意）
RUN flutter config --enable-web

WORKDIR /app
```
---
## ✅ 最後のチェックポイント
| 項目                          | 状態                 |
|-------------------------------|----------------------|
| Flutter SDK on Android Studio | ✅ インストール済     |
| Android実機 or AVD起動        | ✅ 認識されていればOK |
| Firebase CLI（任意）          | ✅ `flutterfire` 動作可 |
| GitHubリポジトリ              | ✅ 構成アップ済       |
---
## 💬 次にやること（おすすめ）
1. Android Studioで flutter_project/ を開く
2. flutter run -d android で実行して実機テスト
3. flutterfire configure を実行（使うなら）
4. Docker側で flutter build を試す（CIや配布用に）
---
## 備考
git cloneでローカルに入れた後は、push先のURLを変更すべし。
```git
$ git remote set-url origin [変更先のURL]
```
