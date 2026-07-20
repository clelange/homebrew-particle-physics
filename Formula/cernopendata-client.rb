class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/cernopendata/cernopendata-client-go"
  version "0.10.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.10.0/cernopendata-client-darwin-amd64"
      sha256 "a0601e299ac155622cef0b83c221667d87b606282882b309c7fd644a435a0122"
    elsif Hardware::CPU.arm?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.10.0/cernopendata-client-darwin-arm64"
      sha256 "0914c3305dce54494b2b14f5ff9ce66bbc020fb875baa84a94da5ee359ae6eeb"
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
