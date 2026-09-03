class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.41"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.41/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d5a9e4ba9e33099c8da9882e1956d0744069d9114350d10aebb0c8be4fac0a6a"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.41/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "07668e81994788eefca703144e93272ed256c724958bc394a18a359eb1939677"
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
