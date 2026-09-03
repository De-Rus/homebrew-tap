cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.42"
  sha256 arm:   "68e55463e55cd2205ab0e81a905bbf8b0612874e97e58fed9204dbbf5de16017",
         intel: "aa1ba53656ad010eab8f8dd5c251e28b30acadd80d38594f83e2c80a90aa737f"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.42/cartapel-#{arch}-apple-darwin.tar.gz",
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
