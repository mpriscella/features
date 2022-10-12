#!/usr/bin/env bash
set -e

if [ "${VERSION}" == "latest" ]; then
	versionStr=$(curl https://api.github.com/repos/mozilla/sops/releases/latest | jq -r '.tag_name')
else
	versionStr=${VERSION}
fi

echo "Installing Sops version ${versionStr}"

architecture=$(dpkg --print-architecture)
case "${architecture}" in
	amd64) architectureStr=amd64 ;;
	arm64) architectureStr=arm64 ;;
	*)
		echo "Sops does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
		exit 1
esac

curl -L "https://github.com/mozilla/sops/releases/download/${versionStr}/sops-${versionStr}.linux.${architectureStr}" \
	-o /usr/local/bin/sops

chmod +x /usr/local/bin/sops
