class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/clelange/cernopendata-client-go"
  version "0.1.4"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.4/cernopendata-client-darwin-amd64"
      sha256 "addb25a2b110b4ebedc54bd22d55e2324cf64d6fafd868ee1dc2a092e2fb17fb"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.4/cernopendata-client-darwin-arm64"
      sha256 "9dd53c4dd7a85d1337b43c3d423653663b23a2566278264f523acee6eac1fcf6"
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
