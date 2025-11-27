cask "calsync" do
  version "1.0.0"
  sha256 "e8be1408da5d86dd8375c6840f0f87f0ca673dd398233534f58b37618cbb2a71"

  url "https://github.com/disbergconsultancy/CAL-SYNC/releases/download/v#{version}/CalSync-#{version}.zip"
  name "CalSync"
  desc "macOS menu bar app for calendar synchronization"
  homepage "https://github.com/disbergconsultancy/CAL-SYNC"

  # Requires macOS 13 (Ventura) or later
  depends_on macos: ">= :ventura"

  app "CalSync.app"

  zap trash: [
    "~/Library/Preferences/com.disbergconsultancy.CalSync.plist",
    "~/Library/Application Support/CalSync",
  ]
end
