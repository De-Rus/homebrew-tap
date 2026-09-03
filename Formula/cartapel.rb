class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.40"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.40/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ff5902babd45ad69796cfab03c3b05ce64b1bede15a9e23786931c12b7344b9"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.40/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "810b772e3c2911a1d8a5f6f8c6ca0661206e20784ebbc45f49f4742c93161342"
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
