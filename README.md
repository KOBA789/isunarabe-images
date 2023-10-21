# ISUNARABE Images
ISUNARABE の練習 VM 用イメージをビルドするためのスクリプト。

## しくみ
- Earthly で `mitamae.tar.gz` (mitamae-tarball) をビルドする
  - mitamae 実行に必要なデータ一式が全て入っている
- `mitamae.tar.gz` を S3 にアップロードする
- EC2 Image Builder のレシピで `mitamae.tar.gz` をダウンロードして mitamae を実行する
- AMI が焼ける

## mitamae-taball のビルド
以下のコマンドで `build/mitamae.tar.gz` が生成される。

```console
$ earthly +mitamae-tarball
```

## ローカルテスト
systemd がインストールされたコンテナで mitamae を実行することでローカルテストを実現している。
systemd の実行のために `-P`(privileged) オプションを付けている。

### ベンチマークまで自動実行する
```console
$ earthly -P +test
```

### 手動で試行錯誤する
docker compose でコンテナを起動すると、`/dev/shm` 以下に `build/` と `test/` がマウントされている。
あとは tarball を展開するなり mitamae を実行するなりして試行錯誤する。

```console
$ docker compose up -d
$ docker compose exec instance /bin/bash
$ ls /dev/shm/
build test
```
