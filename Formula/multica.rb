class Multica < Formula
  desc "Local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/hduhelp/multica"
  version "0.4.10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.4.10/multica-cli-0.4.10-darwin-arm64.tar.gz"
      sha256 "94686b35b55635707bf5729e457935397f4606ec00749b8d2c642c48b680ae19"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.4.10/multica-cli-0.4.10-darwin-amd64.tar.gz"
      sha256 "6650a6a56007670fb4a14ada4b880065f0d27b53084366b339fa0227eb89f7a0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.4.10/multica-cli-0.4.10-linux-arm64.tar.gz"
      sha256 "a48208d9c466cc4b34e2c9d561fd7472d261a40fd56f350f50d2daa409c7451c"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.4.10/multica-cli-0.4.10-linux-amd64.tar.gz"
      sha256 "f464e39fb949fe98940d5349bd124be83dbe5ee69519af90dcedc485514bc58e"
    end
  end

  def install
    bin.install "multica"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/multica version")
  end
end
