class EgiTrustanchors < Formula
  desc "CA certificates from EGI EUGridPMA"
  homepage "https://repository.egi.eu/sw/production/cas/1/current/"
  url "http://repository.egi.eu/sw/production/cas/1/current/tgz/igtf-preinstalled-bundle-classic.tar.gz"
  sha256 "9898fb6dd152ab50488499dd27cbf0c45fa0eb6cc1da26a0305cd7f22b86c4a7"
  version "1.141-1"

  def install
    (prefix/"etc/grid-security-emi/certificates").mkpath
    (etc/"grid-security-emi").mkpath

    cert_dir = prefix/"etc/grid-security-emi/certificates"

    system "tar", "xzf", cached_download

    if Dir.exist?("certificates")
      cp Dir["certificates/*"], cert_dir
    else
      cp Dir["*"], cert_dir
    end

    chmod 0644, Dir["#{cert_dir}/*"]
  end

  def caveats
    <<~EOS
      EGI-trustanchors certificates have been installed to:
        #{prefix}/etc/grid-security-emi/certificates

      These files are typically expected by grid tools to be in:
        /etc/grid-security-emi/certificates

      You have two options to make these certificates accessible:

      1. Symlink the certificates directory (recommended):
         sudo mkdir -p /etc/grid-security-emi
         sudo ln -sf #{prefix}/etc/grid-security-emi/certificates /etc/grid-security-emi/certificates

      2. Configure your grid tools to use this location directly:
         export X509_CERT_DIR="#{prefix}/etc/grid-security-emi/certificates"
    EOS
  end

  test do
    cert_dir = prefix/"etc/grid-security-emi/certificates"
    assert_path_exists cert_dir

    cert_files_count = Dir["#{cert_dir}/*.0"].length
    assert cert_files_count > 50, "Expected at least 50 certificate files"

    assert_path_exists cert_dir/"CERN-Root-2.pem"

    cert_content = File.read(cert_dir/"CERN-Root-2.pem")
    assert_match(/BEGIN CERTIFICATE/, cert_content)

    assert_path_exists etc/"grid-security-emi"
  end
end
