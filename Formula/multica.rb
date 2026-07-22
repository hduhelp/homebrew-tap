class Multica < Formula
  desc "Local agent runtime and management tool for the Multica platform"
  homepage "https://github.com/hduhelp/multica"
  version "0.4.9"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.4.9/multica-cli-0.4.9-darwin-arm64.tar.gz"
      sha256 "c4768d92c8f2158efd63864ffa0f4461a5ffa17adf963b0ee6d49c0d89160cf8"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.4.9/multica-cli-0.4.9-darwin-amd64.tar.gz"
      sha256 "3424b0077a47d3a2f90566c53088e0c7af8aa1506e6d8acdb78fcc57ae249f27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/hduhelp/multica/releases/download/v0.4.9/multica-cli-0.4.9-linux-arm64.tar.gz"
      sha256 "3583512d5cbe829f7ae47018a060bf28062925d99f1c39ab03c574c223b7b0f3"
    else
      url "https://github.com/hduhelp/multica/releases/download/v0.4.9/multica-cli-0.4.9-linux-amd64.tar.gz"
      sha256 "6585711644ce4c7552e96ce5840410fb1c6797ef50e6b0deb2e08dbeb811bb26"
    end
  end

  def install
    bin.install "multica"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/multica version")
  end
end
