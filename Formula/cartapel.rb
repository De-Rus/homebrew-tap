class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.37"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.37/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eeb31680e5cbb160876d5efa5320f31753bf30da21bae8859de3aa6e9fc4983b"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.37/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "82e8c57b6b98b358eae22c49b2372b4da3bfa2f2331ea4539e9851b60cd3dd13"
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
