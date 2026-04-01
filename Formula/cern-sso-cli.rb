class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.31.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.31.0/cern-sso-cli-darwin-amd64-webauthn"
      sha256 "36a0fc5e50815dc5a834221e4b126bd2fc5bedd94cece63ad1797ec6b0819ff7" # darwin-amd64-webauthn
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.31.0/cern-sso-cli-darwin-arm64-webauthn"
      sha256 "f893a00c7139d50921aa56c316f0497ed6c85201c10075326e41a1a23b8e22e7" # darwin-arm64-webauthn
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
