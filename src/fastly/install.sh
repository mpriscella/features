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
	amd64) architectureStr=386 ;;
	arm64) architectureStr=arm64 ;;
	*)
		echo "Fastly does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
		exit 1
esac

curl -L "https://github.com/fastly/cli/releases/download/${versionStr}/fastly_${versionStr}_linux-${architectureStr}.tar.gz" \
	-o fastly.tar.gz

tar -xzf fastly.tar.gz -C /usr/local/bin/
rm fastly.tar.gz
