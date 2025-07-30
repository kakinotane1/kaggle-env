# Kaggle GPU Development Environment

このリポジトリは、Kaggle の GPU イメージをベースにしたコンテナ上で Jupyter Notebook / VS Code Devcontainer を動かす開発環境を提供します。  
`start.sh` に実行権限を付与し実行するだけで、必要な `.env` ファイルの生成から Docker Compose の起動までを自動化します。

---

## 目次

- [前提条件](#前提条件)  
- [セットアップ手順](#セットアップ手順)  
- [ディレクトリ構造](#ディレクトリ構造)  
- [構成ファイルの解説](#構成ファイルの解説)  
  - [.env / .env.sample](#env--envsample)  
  - [Dockerfile](#dockerfile)  
  - [compose.yml](#composeyml)  
  - [devcontainer.json](#devcontainerjson)  
- [使い方](#使い方)  
  - [コンテナ起動](#コンテナ起動)  
  - [Jupyter Notebook へアクセス](#jupyter-notebook-へアクセス)  
  - [VS Code で Devcontainer を開く](#vs-code-で-devcontainer-を開く)  
- [Python パッケージの追加](#python-パッケージの追加)  
- [停止・後片付け](#停止・後片付け)  
- [トラブルシューティング](#トラブルシューティング)  
- [ライセンス](#ライセンス)  

---

## 前提条件

- Docker (>= 20.x) がインストール済み  
- NVIDIA ドライバおよび `nvidia-docker` ランタイムが利用可能  
- （VS Code で開発する場合）Remote – Containers 拡張機能  

---

## セットアップ手順

```bash
git clone https://github.com/kakinotane1/kaggle-env.git
cd kaggle-env

chmod +x start.sh
./start.sh
```

- 初回実行時はプロジェクトルートに `.env`（UID/GID）が生成されます  
- 以降は既存の `.env` を使って迅速に起動  

---

## ディレクトリ構造

``` text
.
├── .devcontainer          # Devcontainer 用設定ファイル
│   ├── Dockerfile         # Kaggle GPU イメージの設定（UID/GID 対応）
│   ├── compose.yml        # Docker Compose によるサービス定義
│   └── devcontainer.json  # VS Code の開発コンテナ設定
├── .env                   # 実行ユーザー UID/GID を定義（自動生成）
├── .env.sample            # .env のサンプル
├── .gitignore
├── LICENSE                # ライセンス情報（MIT License）
├── README.md              # プロジェクト概要（このファイル）
├── inputs/                # Kaggle コンテナの入力ディレクトリ（データ配置）
│   └── .gitkeep
├── notebooks/             # Notebook 保存場所（作業内容）
│   └── .gitkeep
├── scripts/               # Python スクリプトなどの格納先
│   └── .gitkeep
└── start.sh               # コンテナ起動スクリプト（UID/GID生成 + Docker Compose）
```

---

## 構成ファイルの解説

### .env / .env.sample

- UID/GID をホストと合わせてファイル権限問題を回避  
- `start.sh` 実行時に自動生成されます  

### Dockerfile

- ベースイメージ：`gcr.io/kaggle-gpu-images/python`  
- 実行ユーザー：`jupyter`（UID/GID 上書き）  
- ワークディレクトリ：`/kaggle`  

### compose.yml

- `kaggle` サービスを定義  
- ポート：`8888:8888`  
- ボリューム：`.kaggle`, `inputs/`, `notebooks/`, `scripts/`  
- GPU 使用可能（`runtime: nvidia`）  

### devcontainer.json

- VS Code での Devcontainer 設定  
- 拡張機能：Python + Jupyter  

---

## 使い方

### コンテナ起動

```bash
chmod +x start.sh      # 一度だけ
./start.sh             # `.env` 生成＋Docker 起動
```

### Jupyter Notebook へアクセス

- ブラウザで `http://localhost:8888` にアクセス  
- 必要に応じてターミナル表示のトークンを使用  

### VS Code で Devcontainer を開く

- VS Code でプロジェクトを開き、`Remote-Containers: Reopen in Container` を実行  

---

## Python パッケージの追加

1. `requirements.txt` を作成  
2. `Dockerfile` の該当行をアンコメント  
3. `./start.sh` を再実行してビルド  

---

## 停止・後片付け

```bash
cd .devcontainer
docker compose down
```

- コンテナとネットワークが削除されます  
- データはローカルディレクトリに残ります  

---

## トラブルシューティング

- Docker/NVIDIA ドライバが起動しているか確認  
- ポート `8888` が衝突していないか確認  
- エラーメッセージに従ってサービス再起動  

---

## ライセンス

このプロジェクトは MIT ライセンスのもとで公開されています。  
詳細は [LICENSE](./LICENSE) ファイルをご覧ください。

---
