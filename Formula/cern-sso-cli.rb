class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  version "0.25.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.25.0/cern-sso-cli-darwin-amd64-webauthn"
      sha256 "6f230d73526713e5187233d066063bac753742bdccd6f95ac0a61cd03bd3829f" # darwin-amd64-webauthn
    elsif Hardware::CPU.arm?
      url "https://github.com/clelange/cern-sso-cli/releases/download/v0.25.0/cern-sso-cli-darwin-arm64-webauthn"
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
