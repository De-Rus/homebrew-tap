cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.40"
  sha256 arm:   "ea1bbb40a7c7d25b11b4cf9933ca167bee898270ce7c3891a5f6afd0af548771",
         intel: "cf3fc8f5c2413f9a01f4e1279f9130b4432ffa1a341fec0bc0453438feaa9fa6"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.40/cartapel-#{arch}-apple-darwin.tar.gz",
      verified: "github.com/De-Rus/cartapel/"
  name "cartapel"
  desc "Admin panel for your database — one binary, config as code"
  homepage "https://cartapel.com"

  # macOS gets the cask, not the formula: a formula without a bottle takes
  # Homebrew's build-from-source path, which demands current Command Line Tools
  # to install a binary that is already compiled.
  binary "cartapel"

  # Ad-hoc signed, not notarized: Homebrew's own download is not quarantined,
  # but strip the flag anyway so a re-downloaded tarball never trips Gatekeeper.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/cartapel"],
                   must_succeed: false
  end

  zap trash: ["~/.cartapel"]
end
