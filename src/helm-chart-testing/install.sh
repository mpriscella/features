#!/usr/bin/env bash
set -e

if [ -z "${VERSION}" ]; then
	VERSION=latest
fi

if [ "${VERSION}" == "latest" ]; then
	versionStr=$(curl https://api.github.com/repos/helm/chart-testing/releases/latest | jq -r '.tag_name')
else
	versionStr=${VERSION}
fi

echo "Installing Chart Testing version ${versionStr}"

architecture=$(dpkg --print-architecture)
case "${architecture}" in
	amd64) architectureStr=amd64 ;;
	arm64) architectureStr=arm64 ;;
	*)
		echo "Chart Testing does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
		exit 1
esac

curl -L "https://github.com/helm/chart-testing/releases/download/${versionStr}/chart-testing_${versionStr:1}_linux_${architectureStr}.tar.gz" \
	-o ct.tar.gz

tar -xzf ct.tar.gz -C /usr/local/bin/
rm ct.tar.gz
