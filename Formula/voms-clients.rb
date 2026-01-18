class VomsClients < Formula
  desc "voms-clients"
  homepage "italiangrid.github.io/voms"
  url "https://github.com/italiangrid/voms-clients/archive/refs/tags/v3.3.7.zip"
  sha256 "6d6e5668f5ca7c410dd9125356f8dac2a150bd23165e1dda16c0a8631c0481e9"
  license "Apache-2.0"

  depends_on "openjdk"
  depends_on "maven" => :build

  def install
    system "mvn", "package", "-Dmaven.repo.local=$(pwd)/m2repo/", "-Dmaven.javadoc.skip=true"
    system "tar", "-xf", "target/voms-clients.tar.gz"
    share.install "voms-clients/share/java"
    man5.install Dir["voms-clients/share/man/man5/*.5"]
    man1.install Dir["voms-clients/share/man/man1/*.1"]
    bin.install Dir["voms-clients/bin/*"]
  end

  def caveats
    on_macos do
      <<~EOS
        If the Java Runtime cannot be located, make sure to symlink OpenJDK using
          sudo ln -sfn #{opt_libexec}/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
      EOS
    end
  end

  test do
    system "#{bin}/voms-proxy-info", "--version"
  end
end
