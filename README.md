# env_sync

env_sync helps to manage `.env` files of some repositories.

Setup `env.yaml` and just apply! env_sync creates `.env` files each of your related repositories.

```yaml
- dir: "/hoge"
  content: |
    HOGE=fuga
    FOO=bar
- dir: "~/User/code"
  content: |
    PIYO=piyo
  file: .env.development
- dir: "fuga"
  content: |
    PIYO=piyo
```

```console
$ env_sync env.yaml
```

You will find `/hoge/.env` , `~/User/code/.env.development`, `./fuga/.env`

### options

- `dir`: copy destination directory
- `content`: contents of .env file
- `file` (optional): name of .env file (sometimes prefer `.env.development`)

## Installation

```
$ gem install env_sync
```

## Usage

```
$ env_sync path/to/env.yaml
```

## Test

```
$ rake
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
