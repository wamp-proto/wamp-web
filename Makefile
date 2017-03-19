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
	-rm -rf website/wampws/build
	-rm -rf website/wampws/static/img/gen
	-rm -rf website/wampws/build_uploaded/
	-rm -f ./twistd.log
	-rm -f .sconsign.dblite
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

# we should remove our custom uploader, replace with the following,
# but it doesn't work: there is some MIME type issues I suspect ..
# whatever, no time now. for now, leave it with the GH page stuff
deploy: img freeze
	aws s3 sync ./website/wampws/build s3://wamp-proto.org/ --acl public-read --delete --region=eu-west-1

# this is here because I always forget the quirky syntax
fix_sth:
	find . -name "*.html" -exec sed -i"" "s/wamp\.ws/wamp-proto\.org/g" {} \;
