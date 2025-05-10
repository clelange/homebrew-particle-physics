# OSG CA Certificates Automation

This directory contains configuration files for [Updatecli](https://www.updatecli.io/), which is used to automatically update the OSG CA certificates Formula when new versions are released.

## How It Works

1. The GitHub Action scheduled workflow (`../.github/workflows/update-osg-certificates.yml`) runs daily.
2. The workflow uses Updatecli to:
   - Fetch the latest certificate information from `https://repo.opensciencegrid.org/cadist/ca-certs-version-igtf-new`
   - Extract the version number, tarball URL, and SHA256 checksum
   - Update the Homebrew formula if there are changes
   - Create a pull request with the changes

## Configuration Files

- `update-osg-certificates.yaml`: The Updatecli configuration file that defines the update process

## Manual Trigger

You can manually trigger this workflow from the "Actions" tab in GitHub by selecting the "Update OSG CA Certificates" workflow and clicking "Run workflow".

## Troubleshooting

If the workflow fails:

1. Check the workflow run logs in GitHub Actions
2. Verify that the `ca-certs-version-igtf-new` file is accessible
3. Ensure that the GitHub token has appropriate permissions to create pull requests

## Further Information

- [Updatecli Documentation](https://www.updatecli.io/docs/prologue/introduction/)
- [OSG CA Certificates Repository](https://repo.opensciencegrid.org/cadist/)