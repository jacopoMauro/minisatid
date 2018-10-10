FROM debian:stretch
MAINTAINER Jacopo Mauro

RUN apt-get update && \
	apt-get install -y \
		gzip \
 		wget && \
 	rm -rf /var/lib/apt/lists/* && \
	mkdir /tool && \
	cd /tool && \
	wget https://dtai.cs.kuleuven.be/krr/files/software/minisatid/minisatid-3.11.0-Linux.tar.gz && \
	gzip -d minisatid-3.11.0-Linux.tar.gz && \
	tar -xvf minisatid-3.11.0-Linux.tar && \
	mv minisatid-3.11.0-Linux minisatid && \
	rm minisatid-3.11.0-Linux.tar && \
	echo '#! /bin/sh \n\
/tool/minisatid/bin/minisatid-3.11.0 -f=fz "$@"' > /tool/minisatid/fzn-minisatid && \
	chmod 700 /tool/minisatid/fzn-minisatid

ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/tool/minisatid/lib"
ENV PATH "$PATH:/tool/minisatid/"

# minizinc lib not available -> use the standard ones
