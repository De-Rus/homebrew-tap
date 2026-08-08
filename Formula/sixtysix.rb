class Sixtysix < Formula
  desc "Trading agent — your broker keys, local backtests, live orders"
  homepage "https://sixtysix.pro"
  version "0.2.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://get.sixtysix.pro/agent/v0.2.1/sixtysix-agent-aarch64-apple-darwin"
      sha256 "8cd3eb75861a93521e1d2012ec56cd812e437dd911f57f91fc1ca1e5b03b1e83"
    end
    on_intel do
      url "https://get.sixtysix.pro/agent/v0.2.1/sixtysix-agent-x86_64-apple-darwin"
      sha256 "d1396edc1a2d13b380fac4518b26f4b354ead157ad11b4bad459af3d72729490"
    end
  end

  on_linux do
    on_arm do
      url "https://get.sixtysix.pro/agent/v0.2.1/sixtysix-agent-aarch64-unknown-linux-musl"
      sha256 "a1933b9e0bfbabafd9878711e57e226976aea94f99d280bca1d87dcd3e22754d"
    end
    on_intel do
      url "https://get.sixtysix.pro/agent/v0.2.1/sixtysix-agent-x86_64-unknown-linux-musl"
      sha256 "68951f7c90c502b0d5f86be2e9ab94a8e321e883b81f340be0fe4ffba75a876a"
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
