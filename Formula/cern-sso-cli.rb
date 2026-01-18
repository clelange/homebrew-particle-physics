class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.27.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.27.1/cern-sso-cli-darwin-amd64-webauthn"
      sha256 "99f26d61866cf7ae98886b20aee8cf14f3469d28e955afc7912048e17dd13df3" # darwin-amd64-webauthn
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.27.1/cern-sso-cli-darwin-arm64-webauthn"
      sha256 "2297cab0bc0e92d6df1cc2f54bff22fdb24489c8c25f3230240a41896be6216d" # darwin-arm64-webauthn
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
