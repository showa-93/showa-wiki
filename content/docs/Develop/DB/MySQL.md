---
title: MySQL
type: docs
author: showa
lastmod: 2023-10-09T04:14:13+09:00
waight: 1
---

## 基本

### Column

確認

```sql
SHOW COLUMNS FROM v_balance;
```

レコード更新のたびに反映

```sql
updated[/ at timestamp NOT NULL DEFAULT CURRENT]TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

### View

Create

```sql
CREATE OR REPLACE VIEW
[ビュー名]
(
 [カラム]
)
AS
SELECT
  [カラム]
FROM
  [テーブル];
```

MySQL 5.7以前はFrom句にサブクエリを含めることができない

### Trigger

Create

```sql
CREATE TRIGGER [トリガー名] [BEFORE|AFTER] [INSERT|UPDATE|DELETE] ON [テーブル]
FOR EACH ROW
BEGIN
  ...
END;
```

MySQL 5.7以前は２つ以上の処理を含めることができない

確認

```sql
SHOW TRIGGERS WHERE `Trigger`='[テーブル名]';
```

### Procedure

Create

```sql
CREATE PROCEDURE [プロシージャ名]([引数:in/戻り値:out])
BEGIN
  ...
END;
```

確認

```sql
SHOW PROCEDURE STATUS WHERE Name='[テーブル名]';
```

DDLの動的実行

```sql
// sample
SET @ddl = 'ALTER TABLE hogehoge ADD COLUMN hogen int);';
PREPARE ddl_stmt FROM @ddl;
EXECUTE ddl_stmt;
DEALLOCATE PREPARE ddl_stmt;
```

### Partition

Alter

```sql
ALTER TABLE [テーブル名]
PARTITION BY RANGE ([カラム名])
(
  PARTITION [パーティション名]  VALUES LESS THAN 10000,
  PARTITION pmax VALUES LESS THAN MAXVALUE
)
```

確認

```sql
SELECT
  TABLE_SCHEMA,
  TABLE_NAME,
  PARTITION_NAME,
  PARTITION_METHOD,
  PARTITION_EXPRESSION,
  PARTITION_DESCRIPTION
FROM
  INFORMATION_SCHEMA.PARTITIONS
WHERE
  TABLE_NAME = '[テーブル名]';
```

## Tips

### ロック確認とキル

件数とスレッドIDの確認

```bash
mysql> SHOW ENGINE INNODB STATUS\G
```

プロセスの確認

```bash
mysql> show processlist;
mysql> KILL {数字};
```
