# Tiff→PDF変換

InfraViewでTiffをPDFに変換するプロセスを自動化するスクリプト。

## Language

- 日本語 (このページ)
- [English](https://github.com/signak/tiff_to_pdf/blob/master/readme.md)

## Installation

1. [ダウンロード InfraView ＆ Plugins](https://www.irfanview.com/64bit.htm)
2. 両方をインストールする
3. srcフォルダ配下のファイルを下記のように配置する。

```
?[任意のフォルダ]
 ┣ ?ja-JP
 ┃ ┣ ?show_result_msg.psd1
 ┃ ┗ ?tiff_to_pdf.psd1
 ┣ ?show_result_msg.ps1
 ┣ ?tiff_to_pdf.cmd
 ┗ ?tiff_to_pdf.ps1
```

### Additional information

- インストールパスを変更した場合や32ビット版をインストールした場合は、tiff_to_pdf.ps1ファイルを開き、IVIEWの値を変更してください。
- tiff_to_pdf.cmdファイルの名前は、好きな物に変更しても構いません。

## Usage

tiff_to_pdf.cmd をダブルクリックして実行する。
