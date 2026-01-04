class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  url "https://github.com/clelange/cern-sso-cli/archive/refs/tags/v0.20.0.tar.gz"
  sha256 "de72dfa638451fcf16581ea42d61106372788263b2e2e326e1588e8ca6a3f8b4"
  license "GPL-3.0-only"

  depends_on "go" => :build
  depends_on "libfido2" => :optional

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")

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
