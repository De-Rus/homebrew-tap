# sixtysix — Homebrew tap

The [sixtysix](https://sixtysix.pro) trading agent: your broker keys, local
backtests, live orders. It runs on a machine you own; keys stay in
`~/.sixtysix` and are never uploaded.

```sh
brew install de-rus/tap/sixtysix
sixtysix pair <code>     # code from Settings → Connections
sixtysix install         # start on login, restart on crash
```

One command on both platforms. macOS resolves to `Casks/sixtysix.rb` and Linux
to `Formula/sixtysix.rb` — the formula is marked `depends_on :linux` precisely
so macOS falls through to the cask. That matters: a bottle-less formula takes
Homebrew's build-from-source path and demands current Command Line Tools to
install a binary that is already compiled, and nobody installing a trading
agent should need Xcode.

Homebrew owns updates here — the agent's own auto-updater detects `/Cellar/`
and stays off, so `brew upgrade` is the one path.

Both files are generated: every `agent-v*` tag in the main repo re-stamps them
with the release's version and checksums. Edit them there, not here.
