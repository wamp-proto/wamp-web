all:
	@echo "Targets:"
	@echo ""
	@echo "   img                 Generate optimized and compressed images"
	@echo "   freeze              Freeze dynamic Web site into static pages"
	@echo "   test                Test dynamic Web site (Twisted)"
	@echo "   test_frozen         Test frozen Web site (Twisted)"
	@echo "   upload              Upload frozen Web site to S3"
	@echo "   clean               Cleanup"
	@echo ""

clean:
	rm -rf website/wampws/build
	rm -rf website/wampws/static/img/gen
	rm -f ./twistd.log
	rm -f .sconsign.dblite
	scons -uc

img:
	scons img

test: img
	python website/wampws/__init__.py -d --widgeturl ''

test_frozen: img freeze
	twistd -n web --port=8080 --path=./website/wampws/build

ghpages: img freeze
	cp -R website/wampws/build/* ../wamp-proto.github.io/

freeze:
	python website/wampws/__init__.py -f --widgeturl ''

upload:
	scons upload

publish: img freeze upload
