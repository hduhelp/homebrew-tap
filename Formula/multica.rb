class Multica < Formula
  desc "Local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/hduhelp/multica"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.5.0/multica-cli-0.5.0-darwin-arm64.tar.gz"
      sha256 "7368d18c0bf7348d50e93ab43086673d01302ffd45dbc5cd08cd0ad024b99167"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.5.0/multica-cli-0.5.0-darwin-amd64.tar.gz"
      sha256 "1d0696d2ef889b6cab5832c31aae21318df3db31f2176c281cb0e68f6a850c71"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.5.0/multica-cli-0.5.0-linux-arm64.tar.gz"
      sha256 "a2b1741da706a4abe4eddd90c23ccfa2bdc4b39cf6d22afd09352377af937ac3"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.5.0/multica-cli-0.5.0-linux-amd64.tar.gz"
      sha256 "b99f3b8519472de29f14cbc32ebd86660b351adec973c4d59591a3226852dfde"
    end
  end

  def install
    bin.install "multica"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/multica version")
  end
end
