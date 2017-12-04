FROM armhf/debian:jessie

MAINTAINER azcoigreach <azcoigreach@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q --fix-missing && \
				   apt-get -y upgrade && \
				   apt-get -y install --no-install-recommends ca-certificates curl

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 37C84554E7E0A261E4F76E1ED26E6ED000654A3E


RUN set -x \
	&& SYNCTHING_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/syncthing/syncthing/releases/latest | rev | cut -d"/" -f1 | rev) \
	&& tarball="syncthing-linux-arm-${SYNCTHING_VERSION}.tar.gz" \
	&& curl -fSL "https://github.com/syncthing/syncthing/releases/download/${SYNCTHING_VERSION}/"{"$tarball",sha1sum.txt.asc} -O \
	&& gpg --verify sha1sum.txt.asc \
	&& grep -E " ${tarball}\$" sha1sum.txt.asc | sha1sum -c - \
	&& rm sha1sum.txt.asc \
	&& tar -xvf "$tarball" --strip-components=1 "$(basename "$tarball" .tar.gz)"/syncthing \
	&& mv syncthing /usr/local/bin/syncthing \
	&& rm "$tarball"

EXPOSE 22000/tcp 21027/udp 8384/tcp

ENTRYPOINT ["syncthing"]