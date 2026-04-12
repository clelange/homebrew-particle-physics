class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.31.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.31.1/cern-sso-cli-darwin-amd64-webauthn"
      sha256 "17de9d24db21ecd1dba9d062aab2e2803b7f039925301d8dca33a9b02cd4646d" # darwin-amd64-webauthn
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.31.1/cern-sso-cli-darwin-arm64-webauthn"
      sha256 "5af375630088f2a4e0bbd0a9d95eebf0d1557f1e5b077a49176cd757f9af6198" # darwin-arm64-webauthn
    end
  end

  depends_on "libfido2"

  def install
    bin.install "cern-sso-cli-darwin-amd64-webauthn" => "cern-sso-cli" if Hardware::CPU.intel?
    bin.install "cern-sso-cli-darwin-arm64-webauthn" => "cern-sso-cli" if Hardware::CPU.arm?

    chmod 0755, bin/"cern-sso-cli"
    generate_completions_from_executable(bin/"cern-sso-cli", "completion")
  end



  test do
    system bin/"cern-sso-cli", "--version"
  end
end
