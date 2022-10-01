#!/usr/bin/env bash
set -e

if [ "${VERSION}" == "latest" ]; then
	versionStr=$(curl https://api.github.com/repos/fastly/cli/releases/latest | jq -r '.name')
else
	versionStr=${VERSION}
fi

echo "Installing Fastly version ${versionStr}"

architecture=$(dpkg --print-architecture)
case "${architecture}" in
	amd64) architectureStr=amd64 ;;
	arm64) architectureStr=arm64 ;;
	*)
		echo "Fastly does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
		exit 1
esac

curl -L "https://github.com/fastly/cli/releases/download/v${versionStr}/fastly_${versionStr}_linux_${architectureStr}.deb" \
	-o /usr/local/bin/fastly

chmod +x /usr/local/bin/fastly
