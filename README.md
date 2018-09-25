# messari/monero-core

A Monero Core docker image.

[![messari/monero-core][docker-pulls-image]][docker-hub-url] [![messari/monero-core][docker-stars-image]][docker-hub-url] [![messari/monero-core][docker-size-image]][docker-hub-url] [![messari/monero-core][docker-layers-image]][docker-hub-url]

## Tags

- `0.12.3.0`, `latest` ([0.12.3.0/Dockerfile](https://github.com/messari/docker-monero-core/blob/master/0.12.3.0/Dockerfile))

**Picking the right tag**

- `messari/monero-core:latest`: points to the latest stable release available of Monero Core. Use this only if you know what you're doing as upgrading Monero Core blindly is a risky procedure.
- `messari/monero-core:<version>`: based on a slim Debian image, points to a specific version branch or release of Monero Core. Uses the pre-compiled binaries which are fully tested by the Monero Core team.

## What is Monero?

Monero is a privacy cryptocurrency. Learn more about [Monero](https://getmonero.org/).

## What is Monero Core?

Monero Core is the Monero reference client and contains all the protocol rules required for the Monero network to function. Learn more about [Monero Core](https://github.com/monero-project/monero).

## Usage

### How to use this image

This image contains the main binaries from the Monero Core project - `monerod`, `monero-wallet-cli` and `monero-wallet-rpc`. It behaves like a binary, so you can pass any arguments to the image and they will be forwarded to the `monerod` binary:

```sh
❯ docker run --rm messari/monero-core \
  --detach \
```

By default, `monerod` will run as user `monero` for security reasons and with its default data dir (`~/.monero`). If you'd like to customize where `monerod` stores its data, you must use the `MONERO_DATA` environment variable. The directory will be automatically created with the correct permissions for the `monero` user and `monerod` automatically configured to use it.

```sh
❯ docker run -e MONERO_DATA=/var/lib/monerod --rm messari/monero-core
```

You can also mount a directory in a volume under `/home/monero/.monero` in case you want to access it on the host:

```sh
❯ docker run -v ${PWD}/data:/home/monero/.monero --rm messari/monero-core
```


### Exposing Ports

Depending on the network (mode) the Monero Core daemon is running as well as the chosen runtime flags, several default ports may be available for mapping.

Ports can be exposed by mapping all of the available ones (using `-P` and based on what `EXPOSE` documents) or individually by adding `-p`. This mode allows assigning a dynamic port on the host (`-p <port>`) or assigning a fixed port `-p <hostPort>:<containerPort>`.

Example for running a node in `mainnet` mode mapping JSON-RPC/REST and P2P ports:

```sh
docker run --rm -it \
  -p 18080:18080 \
  -p 18081:18081 \
  messari/monero-core
```

To test that mapping worked, you can send a JSON-RPC curl request to the host port:

```
curl -X POST http://foo:YmFy=@127.0.0.1:18081/json_rpc -d '{"jsonrpc":"2.0","id":"0","method":"get_block_count"}' -H 'Content-Type: application/json'
```

#### Mainnet

- JSON-RPC/REST: 18081
- P2P: 18080


## License

The [messari/monero-core][docker-hub-url] docker project is under MIT license.

[docker-hub-url]: https://hub.docker.com/r/messari/monero-core/
[docker-layers-image]: https://img.shields.io/imagelayers/layers/messari/monero-core/latest.svg?style=flat-square
[docker-pulls-image]: https://img.shields.io/docker/pulls/messari/monero-core.svg?style=flat-square
[docker-size-image]: https://img.shields.io/imagelayers/image-size/messari/monero-core/latest.svg?style=flat-square
[docker-stars-image]: https://img.shields.io/docker/stars/messari/monero-core.svg?style=flat-square
