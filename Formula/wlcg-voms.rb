# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class WlcgVoms < Formula
  desc "VOMS configuration files for WLCG Virtual Organizations"
  homepage "https://twiki.cern.ch/twiki/bin/view/LCG/VOMSLSCfileConfiguration"
  url "https://github.com/clelange/wlcg-voms/archive/refs/tags/2025.05.10.zip"
  sha256 "c94458df721d2f9202c5d7195a44cfc8f42e64ebd09565d729d1fcf1cd3fe13f"
  license "Apache-2.0"

  def install
    # Extract the etc directory structure to the formula's prefix
    cp_r "etc", prefix
    
    # Create the grid-security directory in Homebrew's etc
    (etc/"grid-security").mkpath
  end

  def caveats
      <<~EOS
        This formula installs VOMS configuration files for various WLCG VOs.
        These files are typically expected by VOMS-aware tools to be in system-wide
        locations like /etc/grid-security/vomsdir/ and /etc/vomses/.

        Homebrew has installed them into:
          #{prefix}/etc/grid-security/vomsdir/
          #{prefix}/etc/vomses/
        
        You may need to:
        1. Symlink these directories/files to the standard system locations if your
            tools do not allow overriding these paths.
            For example (run with sudo):
              mkdir -p /etc/grid-security
              ln -s #{prefix}/etc/grid-security/vomsdir /etc/grid-security/vomsdir
              ln -s #{prefix}/etc/vomses /etc/vomses
        2. Configure your VOMS client tools (e.g., voms-proxy-init) to look for
            configuration files in the Homebrew prefix, if possible. This often involves
            setting environment variables like VOMS_USERCONF or X509_VOMS_DIR.

        Please check the documentation for your specific VOMS client tools.
      EOS
    end

    test do
      assert_predicate prefix/"etc", :exist?, "Formula's etc directory should exist."
      assert_predicate prefix/"etc/grid-security/vomsdir", :exist?, "'grid-security/vomsdir' directory should be installed in #{prefix}/etc."
      assert_predicate prefix/"etc/vomses", :exist?, "'vomses' directory should be installed in #{prefix}/etc."
      
      # Verify that VO files exist for different experiments
      assert_predicate prefix/"etc/grid-security/vomsdir/cms/voms-cms-auth.cern.ch.lsc", :exist?, "CMS VO LSC file should exist"
      assert_predicate prefix/"etc/vomses/cms-voms-cms-auth.cern.ch", :exist?, "CMS VO vomses file should exist"
      assert_predicate prefix/"etc/grid-security/vomsdir/atlas/voms-atlas-auth.cern.ch.lsc", :exist?, "ATLAS VO LSC file should exist"
      
      # Check that grid-security directory exists in homebrew etc
      assert_predicate etc/"grid-security", :exist?, "grid-security directory should exist in #{etc}"
    end
end
