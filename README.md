# WAMP Protocol Web Site

This repository contains the [Web site](http://wamp-proto.org/) for the [WAMP Protocol](https://github.com/wamp-proto/wamp-proto).

## Building

To build the Web site, you will need Python and Inkscape on your PATH. Further, a number of Python packages are required, and the recommended way is to install in a virtualenv:

```console
~/cpy2711/bin/virtualenv ~/cpy2711_4
source ~/cpy2711_4/bin/activate
pip install -U boto scons scour taschenmesser flask frozen_flask twisted
```

After that, the Web site can be tested:

```console
make test
```

Publishing the Web site (only for admins):

1. pull the repo [wamp-proto.github.io](https://github.com/wamp-proto/wamp-proto.github.io)
2. then `make ghpages` from within this repo
3. push the changes on the GitHub pages repo
