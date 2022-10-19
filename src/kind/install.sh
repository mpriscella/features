#!/usr/bin/env bash
set -e

if [ -z "${VERSION}" ]; then
	VERSION=latest
fi

if [ "${VERSION}" == "latest" ]; then
	versionStr=$(curl https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.tag_name')
else
	versionStr=${VERSION}
fi

echo "Installing Kind version ${versionStr}"

architecture=$(dpkg --print-architecture)
case "${architecture}" in
	amd64) architectureStr=amd64 ;;
	arm64) architectureStr=arm64 ;;
	*)
		echo "Kind does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
		exit 1
esac

curl -L "https://github.com/kubernetes-sigs/kind/releases/download/${versionStr}/kind-linux-${architectureStr}" \
	-o /usr/local/bin/kind

chmod +x /usr/local/bin/kind
