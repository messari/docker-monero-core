#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for monerod"

  set -- monerod "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "monerod" ]; then
  mkdir -p "$MONERO_DATA"
  chmod 700 "$MONERO_DATA"
  chown -R monero "$MONERO_DATA"

  echo "$0: setting data directory to $MONERO_DATA"

  set -- "$@" -datadir="$MONERO_DATA"
fi

if [ "$1" = "monerod" ] || [ "$1" = "monero-cli" ] || [ "$1" = "monero-tx" ]; then
  echo
  exec gosu monero "$@"
fi

echo
exec "$@"
