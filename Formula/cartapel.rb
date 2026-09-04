class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.43"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.43/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0db355caf3710a059f6b8b6141c5a627e0f1c61db79fe26b04d98f84e7ca07b9"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.43/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "026f65b7072a02b1a31025cb20b181d2b49ca3e258ad644bd08f7712e75a30da"
    end
  end

  def install
    bin.install "cartapel"
  end

  def caveats
    <<~EOS
      Point it at a database and a config directory:

        CARTAPEL_DB=postgres://user:pass@host/db cartapel serve --config ./config

      `cartapel check ./config` validates a bundle in CI; the server hot-reloads
      config from disk and keeps the last good one when an edit does not parse.
    EOS
  end

  test do
    assert_match "cartapel #{version}", shell_output("#{bin}/cartapel --version")
  end
end
