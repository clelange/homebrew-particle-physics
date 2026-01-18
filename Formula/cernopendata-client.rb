class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/clelange/cernopendata-client-go"
  version "0.1.3"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.3/cernopendata-client-darwin-amd64"
      sha256 "dcc54435ad7054192e1dc38217a90d0b4fb264cc318c3e89130ea7563d2dfb1d"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.3/cernopendata-client-darwin-arm64"
      sha256 "8a40a93bc322c4de1b1d640d4a2fdd83ad6d988e2a6be9e61f34cb873632da58"
    end
  end

  def install
    bin.install "cernopendata-client-darwin-amd64" => "cernopendata-client" if Hardware::CPU.intel?
    bin.install "cernopendata-client-darwin-arm64" => "cernopendata-client" if Hardware::CPU.arm?

    chmod 0755, bin/"cernopendata-client"
  end

  test do
    system bin/"cernopendata-client", "version"
  end
end
