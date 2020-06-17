FROM kalilinux/kali-rolling

CMD ["bash"]
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt install -y wget gnupg
RUN wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add
RUN echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | tee /etc/apt/sources.list
RUN apt install -y golang git curl  kali-tools-top10

ENV GOPATH /usr/go
RUN mkdir $GOPATH
ENV PATH $GOPATH/bin:$PATH

RUN go get github.com/yudai/gotty

ENV TERM xterm

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
