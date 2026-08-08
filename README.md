# sixtysix — Homebrew tap

The [sixtysix](https://sixtysix.pro) trading agent: your broker keys, local
backtests, live orders. It runs on a machine you own; keys stay in
`~/.sixtysix` and are never uploaded.

```sh
brew install de-rus/tap/sixtysix
sixtysix pair <code>     # code from Settings → Connections
sixtysix install         # start on login, restart on crash
```

Homebrew owns updates here — the agent's own auto-updater stays off, so
upgrade with `brew upgrade sixtysix`.

`Formula/sixtysix.rb` is generated: each `agent-v*` tag in the main repo
re-stamps it with the release's version and checksums. Edit it there, not here.
