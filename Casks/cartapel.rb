cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.37"
  sha256 arm:   "e78ae0be3718d6d31542c837b3d54ca5e9388a1fafa4ae568521bb34b4f8a6d6",
         intel: "e424eeedab2e6fb09e5358ea189ee4961e43ad34875c40280ec8d0d7366ef06f"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.37/cartapel-#{arch}-apple-darwin.tar.gz",
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
