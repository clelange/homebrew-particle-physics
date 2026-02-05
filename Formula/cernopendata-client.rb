class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/clelange/cernopendata-client-go"
  version "0.8.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.8.1/cernopendata-client-darwin-amd64"
      sha256 "61353a687733929daafe8da3fb2765e5097f792abd6b25af54948899a2eb5f97"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.8.1/cernopendata-client-darwin-arm64"
      sha256 "32e26402d08b414d2a654d299379a3a5bb2da004c1f666abc896e84c334d4d76"
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
