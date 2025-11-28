cask "nomas" do
  version "1.0.0"
  sha256 "UPDATE_SHA256_HERE"

  url "https://github.com/disbergconsultancy/CAL-SYNC/releases/download/v#{version}/NoMas-#{version}.zip"
  name "No Mas!"
  desc "macOS menu bar app - No Meeting Auto-Accept for calendar synchronization"
  homepage "https://github.com/disbergconsultancy/CAL-SYNC"

  # Requires macOS 13 (Ventura) or later
  depends_on macos: ">= :ventura"

  app "NoMas.app"

  postflight do
    # Remove quarantine attribute to prevent "damaged app" warning
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/NoMas.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.nomas.app.plist",
    "~/Library/Application Support/NoMas",
  ]

  caveats <<~EOS
    No Mas! is not notarized by Apple. If you see "app is damaged" warning:
      xattr -cr /Applications/NoMas.app
  EOS
end
