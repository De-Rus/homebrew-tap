class Cartapel < Formula
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"
  version "0.9.44"
  license "MIT"

  # Linux only, on purpose: a bottle-less formula takes Homebrew's
  # build-from-source path on macOS, which demands current Command Line Tools
  # to install an already-compiled binary. `brew install de-rus/tap/cartapel`
  # falls through to the cask there, so one command works on both platforms.
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.44/cartapel-aarch64-unknown-linux-musl.tar.gz"
      sha256 "55676f91edf5470182fd55dd63ac195ef2e68ba56f1533440f14f45c70e3a7f9"
    end
    on_intel do
      url "https://github.com/De-Rus/cartapel/releases/download/v0.9.44/cartapel-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1e4b932254afa76838cf3fcef8ac4cbc40494b95f9b4bf952130d014f147af15"
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
