cask "sixtysix" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.2.3"
  sha256 arm:   "e672cb77e8bb4fcb499c337bfd0b69706be05ff4f3118be43bf92d29aa5b3731",
         intel: "26bbafcea36fb787d5ff9ade31eae1c0cf0b340cde1ba6a5a648a5127843f3c2"

  url "https://get.sixtysix.pro/agent/v#{version}/sixtysix-agent-#{arch}-apple-darwin",
      verified: "get.sixtysix.pro/agent/"
  name "sixtysix agent"
  desc "Trading agent — your broker keys, local backtests, live orders"
  homepage "https://sixtysix.pro"

  # macOS gets the cask, not the formula: a formula without a bottle takes
  # Homebrew's build-from-source path, which demands current Command Line Tools
  # to install a binary that is already compiled. Someone installing a trading
  # agent should not need Xcode.
  binary "sixtysix-agent-#{arch}-apple-darwin", target: "sixtysix"

  # The binary is ad-hoc (linker) signed, not notarized. Running it straight
  # from a shell works quarantined, but `sixtysix install` hands it to launchd,
  # which is a stricter launch path — strip the flag rather than find out.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/sixtysix-agent-#{arch}-apple-darwin"],
                   must_succeed: false
  end

  # Deliberately NOT tearing down launchd here. The LaunchAgent is created by
  # the user running `sixtysix install`, not by this cask, and an `uninstall
  # launchctl:` stanza will happily unregister — and delete the plist of — an
  # agent that was installed by some other route entirely. That is a live
  # trading daemon; a dangling job is recoverable, a silently stopped one is
  # not. `sixtysix uninstall` is the supported way to remove the service, and
  # `brew uninstall --zap` sweeps it for anyone who wants everything gone.
  zap launchctl: "pro.sixtysix.agent",
      trash:     [
        "~/.sixtysix",
        "~/Library/LaunchAgents/pro.sixtysix.agent.plist",
      ]

  caveats <<~EOS
    Connect this machine to your account, then run it in the background:

      sixtysix pair <code>     # code from Settings → Connections
      sixtysix install         # start on login, restart on crash

    Broker keys stay in ~/.sixtysix on this machine and are never uploaded.
    Homebrew owns updates here — the agent's self-updater stays off, so
    upgrade with `brew upgrade --cask sixtysix`.

    To remove: `sixtysix uninstall` stops the background service first, then
    `brew uninstall --cask sixtysix`. Add --zap to also delete ~/.sixtysix,
    which holds your broker keys.
  EOS
end
