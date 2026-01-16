class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.24.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.24.0/cern-sso-cli-darwin-amd64-webauthn"
      sha256 "efc98baddfb28ace5a32ae81a0ce226c5aa38742421727d39c6daf7ae099e256" # darwin-amd64-webauthn
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.24.0/cern-sso-cli-darwin-arm64-webauthn"
      sha256 "530fb8b6646f2d602c8421fff545d3a4c7388b7200b8846af9449bb703205f1a" # darwin-arm64-webauthn
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
