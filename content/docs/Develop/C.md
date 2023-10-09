---
title: C
type: docs
author: showa
lastmod: 2023-10-08T16:41:41+09:00
waight: 1
---

[苦しんで覚えるC言語](https://9cguide.appspot.com/index.html)

## 関数

### memcmp

buf1 と buf2 を先頭から n バイト分比較します。比較はunsigned char として行われます。memcmp() は buf1 と buf2 をメモリブロックとして扱うため、途中に空文字('\0')を含んでいても比較を続けます。

```c
#include <string.h>
int memcmp(const void *buf1, const void*buf2,size_t n);
```

### Switch文では、正数か定数しか使えない

```c
 int main(void){
  int hoge = 1;
  switch(hoge) {
   case 1:
    printf("1やで");
   case 2:
    printf("2やで");
   default:
    printf("君だれ？");
  }
 }
```

### [プロトタイプ宣言](http://rainbow.pc.uec.ac.jp/edu/program/b1/Ex5-1.htm)

関数は呼び出す前にコンパイラに情報を渡すために、プロトタイプ宣言する必要がある。  
gccなどでは、プロトタイプ宣言がなくてもコンパイルできるが、基本はエラーとなる。  
また、main関数は、プロトタイプ宣言する必要のない特別な関数。  

```c
  int number(void); # プロトタイプ宣言
 
   int main(void){
    int i = 0;
    for(;;) {
       printf("%d回目\n",number());
       if(i>5){
        break;
      }
      i+=1;
    }
  }

  int number(void){
    return 5;
  }
```

### C言語では文字列の型（string etc...）は存在しない

char型を利用する。ただし、255種(8bit)しか扱えないため全角文字は扱えない。
文字の比較とかの標準ライブラリ：[ctype.h https://www.programiz.com/c-programming/library-function/ctype.h]

C言語では、文字列を配。または文字リテラルで表す。
文字列の最後（EOS）は`\0`で表す。

```c
 int main(void){
  char str[6] = {'A', 'B', '\0'};
  printf("%s\n", str);
  // ""で囲めば宣言できるが、初期化の時にしかつかえない
  char str[] = "hoge";
  printf("%s\n", hoge);
  char input[32];
  scanf("%s", input);
  printf("%s\n",input);
  printf("%ld\n", strlen(input));
  return 0;
 }
```

### ポインタとか

```c
int main(void){
  int i;
  printf("%p\n", &i);
  int arr[4];
  printf("array %p\n", arr);
  for(i = 0; i < 4; i++){
    printf("%d %p\n", i, &arr[i]);
  }
  intp1;
  // nilになる
  printf("pointer %p\n", p1);
  // 0を代入してもnullポインタになる
  p1 = 0;
  printf("pointer %p\n", p1);

  intp2;
  i = 3;
  p2 = &i;
  printf("p2: %p  i: %p\n", p2, &i);
  i = 4;
  printf("p2: %d  i: %d\n", *p2, i);
  *p2 = 6;
  printf("p2: %d  i: %d\n", *p2, i);

  return 0;
}
```

### 関数の引数の配列はポインタ渡し

```c
 #include <stdio.h>
 void hoge(int a[]);
 int main(void){
  int input[5] = {1, 2, 3, 4, 5};
  printf("before: %d\n", input[2]);
  hoge(input);
  printf("after: %d\n", input[2]);
  return 0;
 }

 void hoge(int a[]){
  a[2] = 100;
 }
```

### 配列における［］について

[]はあくまでも配列の先頭のポインタからの演算子。
配列は、先頭から連続したアドレスで作られるので、[]の演算子で値がとれる。
>多くの人が、配列とポインタを勘違いしてしまうようです。
>配列とは、多数の変数を順番つけでまとめて扱う方法であり、
>ポインタとは、変数のショートカットを作る方法です。
>
>それなのに、似たような使い方が出来るのは配列の設計と関係あります。
>C言語では、配列を実現する手段として、ポインタを利用しているからです。
>従って、ポインタ変数では、配列と同等のことが出来てしまいます。
>
>そのため、ポインタと配列は混同しやすいのですが、
>配列はあくまでも多数の変数の先頭を示す固定された変数であり、
>ポインタ変数は、好きな変数のアドレスを代入して、
>好きなメモリ領域を使うことが出来る可変的な変数です。

### 構造体（struct）

```c
 // studentのことを「構造体タグ名」と呼ぶ
 // 厳密には型名じゃない
 struct student_tag {
  int year; /学年 */
  int clas; /クラス */
  int number; /出席番号 */
  char name[64]; /名前 */
  double stature; /身長 */
  double weight; /体重 */
 };
 // 構造体型
 typedef struct student_tag student;
 void student_print(student *data);

/*
一番簡潔な書き方
typedef struct {
  int year;
  int clas;
  int number;
  char name[64];
  double stature;
  double weight;
} student;
*/

int main(void){
  // typedef 指定指定ない場合、structを頭につける必要がある
  // struct student_tag data
  student data;
  data.year = 1;
  student_print(&data);
  strcpy(data.name,"MARIO");
  retrun 0;
 }

void student_print(student *data){
  printf("%d\n", (*data).year);
  // ポインタの構造体変数は、「->」でアクセス可能
  printf("%d\n", data->year);
  (*data).year = 100;
  return;
 }
```

- 構造体の中の配列

  >構造体の中に配列が含まれている場合は、配列の中身もコピーされて渡されます。
  >従って、中身を変更しても、呼び出し元の変数には影響しません。
  >配列をコピーして渡したい時（例えば、リバーシのプログラムで盤面情報を渡したい等）には、
  >構造体にしてしまうのが一番簡単です。
  >従って、構造体の配列を渡すのはとても遅いので、場合によってはやめたほうがいいこともあります

### 定数宣言

#### define

```c
 #include <stdio.h>
 #define EXCISETAX 0.03 /ここで定数を宣言 */
 int main(void)
 {
  int price;
  printf("本体価格:");
  scanf("%d",&price);
  price = (int)((1 EXCISETAX) price); /定数使用 */
  printf("税込価格:%d\n",price);
  return 0;
 }
```

#### const

constよりはdefineのが一般的に使われる。
関数内定数や、関数の引数の型として使われることが多い。

```c
 #include <stdio.h>
 int main(void)
 {
  const double EXCISETAX = 0.05;
  int price;
  printf("本体価格:");
  scanf("%d",&price);
  price = (int)((1 EXCISETAX) price);
  printf("税込価格:%d\n",price);
  return 0;
 }
```

#### enum

```c
 enum {
  ENUM_0,
  ENUM_1,
  ENUM_5 = 5,  // 整数値を直接指定できる
  ENUM_6,   // 6
  ENUM_7,
  ENUM_9 = 9,
 };
```

#### define疑似命令

＃define疑似命令による定数は、単なる置き換えによって実現されている。

```c
 #include <stdio.h>
 // 関数の呼び出しを置き換えることができる
 #define PRINT_TEMP printf("temp = %d\n",temp)
 int main(void)
 {
  int temp = 100;
  PRINT_TEMP;
  return 0;
 }
```

この機能によってマクロという簡単な関数をつくることができる。多用は非推奨。

```c
 #include <stdio.h>
 // ()を使うと引数のように置き換えられる
 #define PRINTM(X) printf("%d\n",X)
 int main(void)
 {
  int a1 = 100,a2 = 50;
  PRINTM(a1);
  PRINTM(a2);
  return 0;
 }
```

### 動的配列

#### malloc

必要なメモリサイズを指定するとそのサイズを確保する。
確保した後、先頭のvoid型のポインタを返す。

#### free

mallocで確保されたメモリの解放処理。
mallocで確保されたメモリはプログラム終了まで確保されるので、メモリリークにならないように必ず開放する。

#### realloc

拡張元の配列の要素数を拡大する。
reallocによって、新たにメモリの領域を確保し、そこに拡張元の配列のコピーを行う。

```c
 int main(void)
 {
  int *heap;
  heap = (int *)malloc(sizeof(int) 10);
  // これだと元のheapのアドレスで確保したメモリがメモリリークしてるので、
  // 別変数に突っ込んで解放してあげる必要ある。
  heap = (int *)realloc(heap,sizeof(int) 100);
  free(heap);
  return 0;
 }
```

- [メモリの動的な確保と解放 https://kaworu.jpn.org/c/%E3%83%A1%E3%83%A2%E3%83%AA%E3%81%AE%E5%8B%95%E7%9A%84%E3%81%AA%E7%A2%BA%E4%BF%9D%E3%81%A8%E8%A7%A3%E6%94%BE]

### extern宣言

宣言だけを行い定義は行わない宣言方法。ヘッダーファイル内で利用する。
宣言を行った変数の定義をどこか1つのソースファイルの中で普通の宣言を行って実体を作成して利用する。
extern宣言を使うと、異なるソースファイルで変数を共有することが出来る。

```h:hoge.h
extern int Number;
```

```c:hoge.c
 #include "hoge.h"
 int Number;
 int sum(int x) {
  Number += x;
  return Number;
 }
```

## debug

### gdb

[gcc+gdbによるプログラムのデバッグ](https://rat.cis.k.hosei.ac.jp/article/devel/debugongccgdb1.html)

## Tips

### ダブルポインタ

- [ダブルポインタ **argv の使い方](http://www.nurs.or.jp/~sug/soft/tora/tora11.htm)
- [ダブルポインタ(ポインタのポインタ)のメリットや使い道を紹介する](https://www.toumasu-program.net/entry/2019/08/26/213512)

### プログレスバー

（あんまりC言語関係ない）
キャリッジリターン（`\r`）を使用すると、行の先頭に移動する制御になる。
コンソールの出力は上書きになるため、1行の範囲なら出力内容の更新が可能。

- [コンソールによるプログレス表示](https://www.mm2d.net/main/prog/c/console-04.html)

### static宣言について

>.ccファイル中に、ファイル外から参照される必要がない定義を行うときは、それらを無名の名前空間内で宣言するか、staticに宣言します。 これらの宣言を.hにおいてはいけません。

- [Google C++ スタイルガイド(日本語全訳) Google C++ Style Guide (Japanese)](https://ttsuki.github.io/styleguide/cppguide.ja.html#Internal_Linkage)

### 参考

- [Kilo Github](https://github.com/antirez/kilo)
  - 1000行でできたC言語製のCUIテキストエディタ
