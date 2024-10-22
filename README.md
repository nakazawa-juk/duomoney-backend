# duomoney-backend

DuoMoney のバックエンドのソースコードを管理するリポジトリ。

## 開発環境の用意手順

### ローカル環境での PostgreSQL セットアップ手順

ローカル環境に PostgreSQL をインストールし、DB クライアントツール（DBeaver）で接続するための手順を説明します。

#### 1. 前提条件

- macOS 環境
- Homebrew がインストールされていること
- DB クライアントツールとして[DBeaver](https://dbeaver.io/download/)を使用

#### 2. PostgreSQL のインストール

まず、Homebrew を使用して PostgreSQL をインストールします。

##### 2.1 Homebrew で PostgreSQL をインストール

ターミナルで以下のコマンドを実行して、PostgreSQL をインストールします。

```bash
brew install postgresql
```

##### 2.2 PostgreSQL サービスの起動

インストールが完了したら、PostgreSQL サービスを起動します。

```bash
brew services start postgresql
```

このコマンドにより、PostgreSQL がバックグラウンドで常に動作するようになります。

##### 2.3 PostgreSQL が正しくインストールされたか確認

以下のコマンドでインストールが成功しているか確認できます。

```bash
postgres --version
```

#### 3. データベースのセットアップ

##### 3.1 PostgreSQL に接続

PostgreSQL のインストールが完了したら、以下のコマンドでデフォルトデータベースに接続します。

```bash
psql postgres
```

##### 3.2 新しいデータベースの作成

以下の SQL コマンドを使って、新しいデータベース `duomoney` を作成します。

```sql
CREATE DATABASE duomoney;
```

##### 3.3 データベースに接続

作成したデータベースに接続するには、次のコマンドを使用します。

```sql
\c duomoney;
```

#### 4. DBeaver での接続設定

1. 現在の接続情報の確認します。

```sql
\conninfo;
```

2. DBeaver を起動し、`New Database Connection` をクリックします。
3. 「PostgreSQL」を選択し、「Next」をクリック。
4. 以下の情報を入力します。
   - **Host**: `localhost`
   - **Port**: `5432`（デフォルトのポート）
   - **Database**: `duomoney`
   - **User**: `your_username`（macOS のユーザー名）
   - **Password**: 必要に応じて入力
5. 「Test Connection」をクリックして接続を確認し、接続が成功したら「Finish」をクリックします。

#### 5. PostgreSQL の起動・停止方法

ローカル環境で PostgreSQL を起動・停止するには、以下のコマンドを使用します。

- PostgreSQL の起動:

  ```bash
  brew services start postgresql
  ```

- PostgreSQL の停止:

  ```bash
  brew services stop postgresql
  ```

#### 6. トラブルシューティング

##### 6.1 PostgreSQL が起動しない場合

PostgreSQL が正しく起動していない場合、以下のコマンドで状態を確認できます。

```bash
brew services list
```

PostgreSQL のステータスが `started` になっていることを確認してください。

##### 6.2 権限エラーや接続エラーが発生した場合

`psql` で権限エラーが発生した場合、正しいユーザーでログインしているか確認してください。ユーザー名やパスワードの問題がある場合は、以下のコマンドでパスワードを再設定できます。

```bash
psql
ALTER USER your_username WITH PASSWORD 'your_password';
```

#### 7. 参考リンク

- [Homebrew 公式サイト](https://brew.sh/)
- [PostgreSQL 公式ドキュメント](https://www.postgresql.org/docs/)
- [DBeaver 公式サイト](https://dbeaver.io/)
