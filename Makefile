prefix = /usr

all: etcd-registrar/etcd-registrar

etcd-registrar/etcd-registrar: etcd-registrar/main.go
	DIR=$$(dirname $^); \
	cd $$DIR; \
	go build -mod vendor

install: etcd-registrar/etcd-registrar
	install -D etcd-registrar/etcd-registrar $(DESTDIR)$(prefix)/bin/etcd-registrar

clean:
	-rm -f etcd-registrar/etcd-registrar
	-rm -f etcd-registrar/go.sum

distclean: clean

uninstall:
	-rm -f $(DESTDIR)$(prefix)/bin/etcd-registrar

.PHONY: all install clean distclean uninstall
