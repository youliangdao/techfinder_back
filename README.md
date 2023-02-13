# サービス概要

個人開発に関する資料を

- 探しやすく
- まとめて管理しやすく

するための技術記事データベースです。

# メインのターゲットユーザー

- 個人開発に興味のあるエンジニア
- 未経験からのエンジニア転職を目指していて、PF 作りに困っている人

# ユーザーが抱える課題

1. 個人開発で参考になる資料は技術サイトや Web 上にたくさん存在しているが、結局どれを参考にすればいいのかわかりづらい。
   <br>

2. 各種技術サイトなどで目的の資料を検索しようとしてもなかなか検索ワードにヒットせず見つからない。

# 解決方法

個人開発に役立つ資料が各メディアに点在しているのを一元化し、それらを人気順やカテゴリ別に分類した「個人開発資料専用データベース」を作成することで、上記 1.2 の課題を一気に解消する

**（活用例）**

- どの資料が人気なのかひと目でわかるようになり、参考にしたい記事が調べやすくなる
- カテゴリ別に分類されていることにより、直感的に調べやすくなる

# 実装予定の機能

以下、検索目的や保存目的の資料を「記事」と呼ぶ

## 一般ユーザー

- **<code>トップページに訪れたユーザーがカテゴリに紐づいた記事一覧画面に遷移できる</code>**
  - ユーザーがトップページの人気カテゴリを閲覧できる
    - ユーザーがトップページの人気カテゴリからカテゴリを直接クリックすることで、そのカテゴリに紐づいた記事一覧画面に遷移できる
  - ユーザーがトップページからすべてのカテゴリ画面に遷移できる
    - ユーザーがすべてのカテゴリ画面から調べたいカテゴリを検索することができる
      - 検索後、カテゴリを直接クリックすることでカテゴリに紐づいた記事一覧画面に遷移できる
    - ユーザーがすべてのカテゴリ画面からカテゴリを直接クリックすることで、そのカテゴリに紐づいた記事一覧画面に遷移できる
    - ユーザーがすべてのカテゴリ画面から人気のカテゴリを閲覧できる
      - 人気カテゴリのカテゴリをクリックすることで、そのカテゴリ紐づいた記事一覧画面に遷移できる
        <br>
- **<code>トップページに訪れたユーザーが記事を検索できる</code>**
  - ユーザーがトップページの急上昇中の記事を閲覧できる
    - ユーザーがトップページの急上昇中の記事から記事をクリックすることで、記事詳細画面に遷移できる
      - ユーザーが記事詳細画面から参照元の記事にアクセスできる
  - ユーザーがトップページからすべての記事画面にアクセスできる
    - ユーザーがすべての記事画面から直接記事をクリックすることで記事詳細画面に遷移できる
      - ユーザーが記事詳細画面から参照元の記事にアクセスできる
    - ユーザーがすべての記事画面から調べたい記事をタイトル検索できる
      - 検索後に記事をクリックすることで記事詳細画面に遷移できる
        - ユーザーが記事詳細画面から参照元の記事にアクセスできる
    - ユーザーが記事一覧画面上で「すべて」「急上昇中」「人気記事」タブを押すことで一覧画面の切り替えができる
      - 切り替わった画面上から記事を直接クリックすることで記事詳細画面に遷移できる
        - ユーザーが記事詳細画面から参照元の記事にアクセスできる
        - ユーザーが記事詳細画面でコメントできる
      - 切り替わった画面からもタイトル検索が可能
        - 検索後に記事をクリックすることで記事詳細画面に遷移できる
          - ユーザーが記事詳細画面から参照元の記事にアクセスできる
  - ユーザーがトップページから各カテゴリに紐づいた記事一覧に遷移できる
    - ユーザーが直接記事をクリックすることで記事詳細画面に遷移できる
      - ユーザーが記事詳細画面から参照元の記事にアクセスできる
    - ユーザーが調べたい記事をタイトル検索できる
      - 検索後に記事をクリックすることで記事詳細画面に遷移できる
        - ユーザーが記事詳細画面から参照元の記事にアクセスできる
    - 「すべて」「急上昇中」「人気記事」タブで一覧画面の切り替えができる
      - 切り替わった画面上から記事を直接クリックすることで記事詳細画面に遷移できる
        - ユーザーが記事詳細画面から参照元の記事にアクセスできる
      - 切り替わった画面からもタイトル検索が可能
        - 検索後に記事をクリックすることで記事詳細画面に遷移できる
          - ユーザーが記事詳細画面から参照元の記事にアクセスできる

<br>

## ログインユーザー

以下一般ユーザーが使用可能な機能はすべて使用可能の前提のもと記述する

- ユーザーがトップページ上の急上昇中の記事一覧上の各記事のいいね・ストックボタンを押下することができる
- ユーザーがカテゴリに紐づく記事一覧画面上の各記事のいいね・ストックボタンを押下することができる
- ユーザーがすべての記事画面から各記事のいいね・ストックボタンを押下することができる
- ユーザーが記事詳細画面から各記事に対してコメントを書くことができる
- ユーザーが記事詳細画面から各記事に対してコメントを書くことができる
- ユーザーが記事詳細画面のコメントのいいねボタンを押下することができる
- ユーザーがヘッダーのアバター画像をクリックするとマイページへ遷移できる
  - マイページ上でいいね・ブックマーク・コメントした記事の一覧を見ることができる
  - マイページ上の「いいね」「ブックマーク」「コメント」タブ押下で一覧画面の切り替えができる
  - マイページ上のプロフィール編集ボタンからプロフィール編集ページへ遷移できる
    - プロフィール編集ページで「アバター画像」「ニックネーム」「自己紹介」「GitHub ユーザー名」「Twitter ユーザー名」を更新することができる
- ユーザーがヘッダーのアバター画像をクリックするとログアウトできる

## 管理ユーザー

- ログインユーザーの検索、一覧、詳細、編集
- カテゴリの一覧、詳細、作成、詳細、編集、削除
- 記事の一覧、詳細、作成、編集、削除
- 管理ユーザーの一覧、詳細、作成、編集、削除

# なぜこのサービスを作りたいのか？

自分が以前個人開発をしようとして技術記事を調べていた際に、記事が多すぎてどれを参考にすればいいのかわからず非常に苦労した。

また自分が使用したい技術を使っている記事を調べようとしても、そういったカテゴリ別にまとまっていないため、目的の記事にたどり着くまでかなり時間がかかった。

そういった経験から、個人開発に関する資料や技術記事だけをまとめたサイトがあったら便利だなぁと思い、開発するに至りました

# スケジュール

- 企画〜技術調査：12/3
- README〜ER 図作成：12/3
- メイン機能実装：12/3 - 1/10
- β 版を RUNTEQ 内リリース（MVP）：1/10 〆切
- 本番リリース：2 月中旬
