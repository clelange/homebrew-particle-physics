class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/cernopendata/cernopendata-client-go"
  version "0.9.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.9.0/cernopendata-client-darwin-amd64"
      sha256 "4bd1e5ed5d83c06dedbae6f4333da25825e79957a624ee2a6e3c152fa4096174"
    elsif Hardware::CPU.arm?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.9.0/cernopendata-client-darwin-arm64"
      sha256 "8679e95295153dd184aed2d650fd22970afb624f493b04b4aade997e4a1af4f3"
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
