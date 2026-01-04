class CernSsoCli < Formula
  desc "Command-line interface to obtain CERN SSO cookies and tokens"
  homepage "https://github.com/clelange/cern-sso-cli"
  url "https://github.com/clelange/cern-sso-cli/archive/refs/tags/v0.19.1.tar.gz"
  sha256 "0d07f9d6b5db438bc19a0e43eedd59b23489b61aa43bcc56fd19c139bf4d2176"
  license "GPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/homebrew/core"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "86ca8c60a32fa00097f58e32ce1e4fcd25b0aa0968c6cf262c22582070e96a2c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "86ca8c60a32fa00097f58e32ce1e4fcd25b0aa0968c6cf262c22582070e96a2c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "86ca8c60a32fa00097f58e32ce1e4fcd25b0aa0968c6cf262c22582070e96a2c"
    sha256 cellar: :any_skip_relocation, sonoma:        "5130a6d33e92fd0d12b828ce526579bc0db5847c8939ad65ff6d6d55052694b1"
    sha256 cellar: :any_skip_relocation, ventura:       "5130a6d33e92fd0d12b828ce526579bc0db5847c8939ad65ff6d6d55052694b1"
  end

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
