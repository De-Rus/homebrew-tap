class Sixtysix < Formula
  desc "Trading agent — your broker keys, local backtests, live orders"
  homepage "https://sixtysix.pro"
  version "0.8.11"
  license :cannot_represent

  # Linux only, on purpose. A bottle-less formula takes Homebrew's
  # build-from-source path, which demands current Command Line Tools to install
  # an already-compiled binary — someone installing a trading agent should not
  # need Xcode. Restricting this here is what makes `brew install
  # de-rus/tap/sixtysix` fall through to the cask on macOS, so one command works
  # on both platforms.
  depends_on :linux

  # Wrapped in on_linux so the formula carries NO url on macOS: an installable
  # formula there wins the name and dies on the requirement above, instead of
  # letting `brew install de-rus/tap/sixtysix` fall through to the cask.
  on_linux do
    on_arm do
      url "https://get.sixtysix.pro/agent/v0.8.11/sixtysix-agent-aarch64-unknown-linux-musl"
      sha256 "c47f03502073e5c1e53db6866dfba8befb064508b207f52269e488e650223398"
    end
    on_intel do
      url "https://get.sixtysix.pro/agent/v0.8.11/sixtysix-agent-x86_64-unknown-linux-musl"
      sha256 "0a1be153cd4d4a3f99087b78803bd24b0684a63b480e9cb4c12cd21a35483b82"
    end
  end

  def install
    bin.install Dir["sixtysix-agent-*"].first => "sixtysix"
  end

  # No `service do` block on purpose: `sixtysix install` registers the agent
  # with systemd itself. Adding brew services would leave two supervisors
  # fighting over one daemon.
  def caveats
    <<~EOS
      Connect this machine to your account, then run it in the background:

        sixtysix pair <code>     # code from Settings → Connections
        sixtysix install         # start on login, restart on crash

      Broker keys stay in ~/.sixtysix on this machine and are never uploaded.
      Homebrew owns updates here — the agent's self-updater stays off, so
      upgrade with `brew upgrade sixtysix`.
    EOS
  end

  test do
    assert_match "sixtysix #{version}", shell_output("#{bin}/sixtysix --version")
    # Unpaired is the only state a sandboxed test can reach; it must fail
    # cleanly rather than hang waiting on a network call.
    assert_match(/pair|not paired|Account/i, shell_output("#{bin}/sixtysix status 2>&1", 0))
  end
end
