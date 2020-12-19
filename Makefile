
rebuild:
	hugo
.PHONY: rebuild

serve:
	hugo serve
.PHONY: serve

clean:
	rm -rf public
.PHONY: clean

deploy: rebuild
	git -C public add -A || true
	git -C public commit -m "Update site" || true
	git -C public  push origin master
