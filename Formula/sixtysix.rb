class Sixtysix < Formula
  desc "Trading agent — your broker keys, local backtests, live orders"
  homepage "https://sixtysix.pro"
  version "0.2.3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.sixtysix.pro/agent/v0.2.3/sixtysix-agent-aarch64-apple-darwin"
      sha256 "e672cb77e8bb4fcb499c337bfd0b69706be05ff4f3118be43bf92d29aa5b3731"
    end
    on_intel do
      url "https://get.sixtysix.pro/agent/v0.2.3/sixtysix-agent-x86_64-apple-darwin"
      sha256 "26bbafcea36fb787d5ff9ade31eae1c0cf0b340cde1ba6a5a648a5127843f3c2"
    end
  end

  on_linux do
    on_arm do
      url "https://get.sixtysix.pro/agent/v0.2.3/sixtysix-agent-aarch64-unknown-linux-musl"
      sha256 "27b9d765b86b61e6684df22a32d6b4f4d62cfbd31c3654f46210026dfa02ffdc"
    end
    on_intel do
      url "https://get.sixtysix.pro/agent/v0.2.3/sixtysix-agent-x86_64-unknown-linux-musl"
      sha256 "97acc51f9e9220b74d8b46de4017dd0ecab2048677c3b3f552a18e71ff296546"
    end
  end

  def install
    bin.install Dir["sixtysix-agent-*"].first => "sixtysix"
  end

  # No `service do` block on purpose: `sixtysix install` registers the agent with
  # launchd/systemd itself. Adding brew services would leave two supervisors
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
