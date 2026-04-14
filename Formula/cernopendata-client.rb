class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/cernopendata/cernopendata-client-go"
  version "0.9.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.9.1/cernopendata-client-darwin-amd64"
      sha256 "d13eb11ade2adc37e3cab4048e4b96bbd410c97e64f79a11134189ed5423fea5"
    elsif Hardware::CPU.arm?
      url "https://github.com/cernopendata/cernopendata-client-go/releases/download/v0.9.1/cernopendata-client-darwin-arm64"
      sha256 "bd9e57646cde8bc361eeecd45efa6bf339c813d7fabb52d652f9bd337b9003f0"
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
