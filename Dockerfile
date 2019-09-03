FROM golang:1.12 AS BUILD

#doing dependency build separated from source build optimizes time for developer, but is not required
#install external dependencies first
ADD /main.dep $GOPATH/src/etcd-registrar/main.go
ADD /etcd-registrar $GOPATH/src/etcd-registrar

WORKDIR $GOPATH/src/etcd-registrar

RUN go get -v etcd-registrar

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /etcd-registrar main.go

FROM alpine

RUN apk add bash

ENV LOG_LEVEL 'info'

COPY --from=BUILD /etcd-registrar /bin/
ADD startup.sh /

ENV ETCD_URL ""
ENV ETCD_BASE ""
ENV SERVICE ""
ENV PORT "3000"
ENV INFO ""
ENV TTL 60
ENV LIST false

CMD [ "/startup.sh" ]

