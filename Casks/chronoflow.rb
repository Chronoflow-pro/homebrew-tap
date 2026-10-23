cask "chronoflow" do
  version "0.0.10"
  sha256 "7806448124deb991be4e371982c0f84555140310208ec9af5e46697bdf0003ac"

  url "https://github.com/Chronoflow-pro/desktop/releases/download/desktop-v#{version}/Chronoflow_#{version}_universal.dmg"
  name "Chronoflow"
  desc "Project management with kanban boards and time tracking"
  homepage "https://chronoflow.pro/"

  livecheck do
    url :url
    regex(/^desktop-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  auto_updates true
  depends_on :macos

  app "Chronoflow.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Chronoflow.app"]
  end

  uninstall quit: "pro.chronoflow.desktop"

  zap trash: [
    "~/Library/HTTPStorages/chronoflow-desktop.binarycookies",
    "~/Library/WebKit/chronoflow-desktop",
  ]
end
