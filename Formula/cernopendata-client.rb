class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/clelange/cernopendata-client-go"
  version "0.4.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.4.0/cernopendata-client-darwin-amd64"
      sha256 "b5668fda42b2100ff77b3d2c6f0c48d58ac3184c187cf4046cc64f70098173ce"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.4.0/cernopendata-client-darwin-arm64"
      sha256 "4be867058d42cfe4774615a782bd2670a6bf35b09a0dcfe227f99f7d6eb90c6f"
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
