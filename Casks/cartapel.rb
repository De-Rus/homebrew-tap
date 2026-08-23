cask "cartapel" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.9.36"
  sha256 arm:   "b4d92904089607a9c20ceb97f0c2282a620f440eaf650a932df46e126ceba0ec",
         intel: "5cb55a141ec131f6bd2ed8df111970395db60587e66392c1293c16c5dc323be1"

  url "https://github.com/De-Rus/cartapel/releases/download/v0.9.36/cartapel-#{arch}-apple-darwin.tar.gz",
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
