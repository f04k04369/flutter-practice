# Flutter 開発テンプレート（Android Studio + Docker 対応）
このリポジトリは、Flutter開発を安定的に行うための構成テンプレートです。  
以下の2通りの開発スタイルに対応しています：
## ✅ 開発スタイル（おすすめ）
| スタイル          | 説明 |
|-------------------|------|
| 💻 Android Studio | 実機テスト・GUI開発に最適（Mac/Win/Linux） |
| 🐳 Docker + VSCode | Firebase連携・ビルド自動化・CI向き        |

---
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
コマンド例（VSCode + Remote Containers推奨）
```bash
flutter build apk     # Android用APK出力
flutter build web     # Web用ビルド（build/web/index.html）
```
---
## 🔥 Firebase連携（必要な場合）
```bash
flutterfire configure
```
`これにより firebase_options.dart が自動生成されます`
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
