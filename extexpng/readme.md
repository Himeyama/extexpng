# ExTexPNG

## Description 説明

This is a web server that provides a TeX to PNG image conversion service.

TeX を PNG 画像に変換するサービスを行うウェブサーバーです。


## Dependent packages 依存するパッケージ
- WSL2
- Ruby
- TeXLive (Install from ISO)

## How to start the service サービスを開始する方法

Start the service with the following command.

次のコマンドでサービスを開始します。

```sh
wsl -- cd ~/extexpng`; sudo ruby ./server.rb
```

http://localhost:31415/gen

## Settings 設定

`. /config.yaml` to set up your private and public keys.

`./config.yaml` 下で共通鍵と秘密鍵の設定等行う必要があります。

```yaml
certkey: 
privkey: 
keyword: 
```

## Network ネットワーク設定

```ps1
$path = wsl -- wslpath -w ~/extexpng/; pwsh "${path}\extexpng.ps1" # Enable 有効
$path = wsl -- wslpath -w ~/extexpng/; pwsh "${path}\extexpng.ps1" disable # Disable 無効
```