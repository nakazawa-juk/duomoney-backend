-- テーブルの作成
CREATE TABLE users (
  user_id UUID PRIMARY KEY, -- ユーザーID
  username VARCHAR(255) NOT NULL, -- ユーザーネーム
  email VARCHAR(255) NOT NULL, -- メールアドレス
  password VARCHAR(255) NOT NULL, -- パスワードハッシュ
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 最終更新日時
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- 論理削除用のフラグ
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_email ON users (email);

-- テーブルの作成
CREATE TABLE accounts (
  account_id UUID PRIMARY KEY, -- アカウントID
  owner_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, -- オーナーID
  partner_id UUID REFERENCES users(user_id) ON DELETE SET NULL, -- パートナーID
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 最終更新日時
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- 論理削除用のフラグ
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_accounts_owner_id ON accounts (owner_id);
CREATE INDEX idx_accounts_partner_id ON accounts (partner_id);

-- テーブルの作成
CREATE TABLE transactions (
  transaction_id UUID PRIMARY KEY, -- 取引ID
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, -- ユーザーID
  amount NUMERIC(10, 2) NOT NULL, -- 金額
  transaction_type VARCHAR(50) NOT NULL, -- 取引タイプ
  category_id UUID REFERENCES categories(category_id) ON DELETE SET NULL, -- カテゴリID
  description TEXT, -- 説明
  transaction_date TIMESTAMP NOT NULL, -- 取引日
  is_recurring BOOLEAN NOT NULL, -- 定期取引フラグ
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 最終更新日時
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- 論理削除用のフラグ
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_transactions_user_id ON transactions (user_id);
CREATE INDEX idx_transactions_category_id ON transactions (category_id);

-- テーブルの作成
CREATE TABLE categories (
  category_id UUID PRIMARY KEY, -- カテゴリID
  category_name VARCHAR(255) NOT NULL, -- カテゴリ名
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 最終更新日時
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- 論理削除用のフラグ
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_categories_category_name ON categories (category_name);

-- テーブルの作成
CREATE TABLE budgets (
  budget_id UUID PRIMARY KEY, -- 予算ID
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, -- ユーザーID
  category_id UUID NOT NULL REFERENCES categories(category_id) ON DELETE CASCADE, -- カテゴリID
  budget_amount NUMERIC(10, 2) NOT NULL, -- 予算金額
  start_date DATE NOT NULL, -- 予算の開始日
  end_date DATE NOT NULL, -- 予算の終了日
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 最終更新日時
  is_deleted BOOLEAN NOT NULL DEFAULT FALSE -- 論理削除用のフラグ
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_budgets_user_id ON budgets (user_id);
CREATE INDEX idx_budgets_category_id ON budgets (category_id);

-- テーブルの作成
CREATE TABLE notifications (
  notification_id UUID PRIMARY KEY, -- 通知ID
  user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, -- ユーザーID
  notification_type VARCHAR(50) NOT NULL, -- 通知タイプ
  message TEXT NOT NULL, -- メッセージ
  is_read BOOLEAN NOT NULL DEFAULT FALSE, -- 既読フラグ
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- 最終更新日時
);

-- インデックスの作成（必要ならば追加）
CREATE INDEX idx_notifications_user_id ON notifications (user_id);
