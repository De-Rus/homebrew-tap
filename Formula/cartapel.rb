class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.39"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.39/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0ae7ee632fa997a6704d6d15fd7df5226a633508ec24c3c4b85fbc0ea5459078"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.39/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bfe66cb064a1e23c7ba7a8cd75d0bf63185356d1f79fbccc61f8fd1ba1a18804"
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
