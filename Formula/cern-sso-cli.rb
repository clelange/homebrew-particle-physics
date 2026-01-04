class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.20.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.20.0/cern-sso-cli-darwin-amd64"
      sha256 "d64786c97113555b135a18fdaaa89605859b4b1286eaf281b24c85780680e656"
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.20.0/cern-sso-cli-darwin-arm64"
      sha256 "3d995ecc753e43436159bc9f920d7b72d112dfc789fb1c5f1c328b2740e1ebf8"
    end
  end

  depends_on "libfido2" => :optional

  def install
    bin.install "cern-sso-cli-darwin-amd64" => "cern-sso-cli" if Hardware::CPU.intel?
    bin.install "cern-sso-cli-darwin-arm64" => "cern-sso-cli" if Hardware::CPU.arm?

    generate_completions_from_executable(bin/"cern-sso-cli", "completion")
  end

  def caveats
    <<~EOS
      To use WebAuthn (YubiKey) support, install libfido2:
        brew install libfido2
      EOS
  end

  test do
    system bin/"cern-sso-cli", "--version"
  end
end
