.PHONY: all clean

all: .uptodate.kubeyaml

clean:
	rm .uptodate.kubeyaml
	rm kubeyaml.tar.gz
	rm -r dist

kubeyaml.tar.gz: kubeyaml.py kubeyaml.spec
	docker run --rm -v "$(shell pwd):/src/" six8/pyinstaller-alpine \
		--noconfirm \
		kubeyaml.py
	tar -C dist/kubeyaml -cz -f "$@" .

.uptodate.kubeyaml: kubeyaml.tar.gz Dockerfile
	docker build -t squaremo/kubeyaml .
	touch $@