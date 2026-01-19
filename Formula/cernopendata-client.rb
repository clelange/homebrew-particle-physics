class CernopendataClient < Formula
  desc "CERN Open Data Client"
  homepage "https://github.com/clelange/cernopendata-client-go"
  version "0.1.5"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.5/cernopendata-client-darwin-amd64"
      sha256 "44a3ef8fa4666894bcef5ba5fa3faf5a8928b78894047023e5146431eb928592"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cernopendata-client-go/releases/download/v0.1.5/cernopendata-client-darwin-arm64"
      sha256 "2899f536c47b8b76909f40b5e421ff9f237a7a2c64a46ce00889f01f804b312c"
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
