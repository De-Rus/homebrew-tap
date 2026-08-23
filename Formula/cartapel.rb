class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.36"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.36/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1195bde84d95fe3a185ee5c405a5b9632b7305d68bee37b74cb74c34caf31c52"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.36/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e6b7c925e08cd5814a36efcaa2f01292b293c6ebe03886e7a45e599fc62e8eca"
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
