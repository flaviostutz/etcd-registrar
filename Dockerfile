FROM golang:1.10 AS BUILD

#doing dependency build separated from source build optimizes time for developer, but is not required
#install external dependencies first
ADD /main.dep $GOPATH/src/etcd-registrar/main.go
RUN go get -v etcd-registrar

#now build source code
ADD /etcd-registrar $GOPATH/src/etcd-registrar
RUN go get -v etcd-registrar



FROM golang:1.10

ENV LOG_LEVEL 'info'

COPY --from=BUILD /go/bin/* /bin/
ADD startup.sh /

ENV ETCD_URL ""
ENV ETCD_BASE ""
ENV SERVICE ""
ENV NAME ""
ENV INFO ""
ENV TTL 60
ENV LIST false

CMD [ "/startup.sh" ]

