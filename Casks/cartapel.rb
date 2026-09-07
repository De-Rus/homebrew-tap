cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.44"
  sha256 arm:   "b3c26d1afee52814e1e3c28a17ca7a587db5524ec2ea58f20ee1748ceb3200bf",
         intel: "f4aa89840d91667421b1d759ca94b6b595b99a575034b8f3a2bfff4ed4ea89a2"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.44/cartapel-#{arch}-apple-darwin.tar.gz",
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
