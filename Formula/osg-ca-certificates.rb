class OsgCaCertificates < Formula
  desc "CA certificates from the Open Science Grid"
  homepage "https://repo.opensciencegrid.org/cadist/"
  url "http://repo.opensciencegrid.org/cadist/1.136IGTFNEW/osg-certificates-1.136IGTFNEW.tar.gz"
  sha256 "7d81c62bcec5bd90d390f2c9878d4c2dc647c28f512bf2e9467b3ffe44426cc3"

  def install
    # Create directories
    (prefix/"etc/grid-security/certificates").mkpath
    (etc/"grid-security").mkpath

    # Target directory for certificates
    cert_dir = prefix/"etc/grid-security/certificates"

    # Extract the tarball
    system "tar", "xzf", cached_download

    if Dir.exist?("certificates")
      # Install certificates to prefix/etc directory
      cp Dir["certificates/*"], cert_dir
    else
      raise "Certificates directory not found in the tarball"
    end

    # Ensure files are readable
    chmod 0644, Dir["#{cert_dir}/*"]
  end

  def caveats
    <<~EOS
      OSG CA certificates have been installed to:
        #{prefix}/etc/grid-security/certificates

      These files are typically expected by grid tools to be in:
        /etc/grid-security/certificates

      You have two options to make these certificates accessible:

      1. Symlink the certificates directory (recommended):
         sudo mkdir -p /etc/grid-security
         sudo ln -sf #{prefix}/etc/grid-security/certificates /etc/grid-security/certificates

      2. Configure your grid tools to use this location directly:
         export X509_CERT_DIR="#{prefix}/etc/grid-security/certificates"
    EOS
  end

  test do
    # Verify directory exists
    cert_dir = prefix/"etc/grid-security/certificates"
    assert_path_exists cert_dir

    # Test for certificate files (should have many)
    cert_files_count = Dir["#{cert_dir}/*.0"].length
    assert cert_files_count > 50, "Expected at least 50 certificate files"

    # Verify specific known files from the distribution
    assert_path_exists cert_dir/"CERN-Root-2.pem"
    assert_path_exists cert_dir/"cacerts_sha256sum.txt"

    # Verify a certificate file has expected content
    cert_content = File.read(cert_dir/"CERN-Root-2.pem")
    assert_match(/BEGIN CERTIFICATE/, cert_content)

    # Check that grid-security directory exists in homebrew etc
    assert_path_exists etc/"grid-security"
  end
end
