prefix = /usr

all: etcd-registrar/etcd-registrar

etcd-registrar/etcd-registrar: etcd-registrar/main.go
	#mkdir -p debian/tmp/.cache
	DIR=$$(dirname $^); \
	cd $$DIR; \
	GOCACHE=$$(pwd)/../debian/tmp/.cache go build -mod vendor

install: etcd-registrar/etcd-registrar
	install -D etcd-registrar/etcd-registrar $(DESTDIR)$(prefix)/bin/etcd-registrar

clean:
	-rm -f etcd-registrar/etcd-registrar
	-rm -f etcd-registrar/go.sum
	-rm -rf debian/tmp/.cache

distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/etcd-registrar

.PHONY: all install clean distclean uninstall
