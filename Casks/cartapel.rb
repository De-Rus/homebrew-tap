cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.43"
  sha256 arm:   "4dafb2355d0284fc19dfb513abb235c8c24246e8e81c3ea841ff6db050c8b525",
         intel: "c32bf02747c4192cad554729dd95162ec4778d256036daeebad20ecf89e0ca69"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.43/cartapel-#{arch}-apple-darwin.tar.gz",
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
