# Rack::Cluster

Tools for managing multiple rackup processes. Built in the image of mongrel_cluster. The real use case is a work around for this [mongrel_rails/Rails >=2.3.3 issue](https://rails.lighthouseapp.com/projects/8994/tickets/2844-bad-content-type-error-in-rack-10-with-first-cgi-mongrel-request).

## Install

    gem install rack-cluster -s http://gemcutter.com

## Usage

    rack-cluster [options] command
        -C, --config PATH
        -p, --port PORT                  use PORT
        -E, --env ENVIRONMENT            use ENVIRONMENT for defaults
        -N, --num-servers INT
        -s, --server SERVER              serve using SERVER (webrick/mongrel)
        -P, --pid FILE                   file to store PID
        -c, --chdir PATH
        -u, --config-ru PATH
        -b, --rackup-bin PATH
        -v, --verbose
        -h, --help                       Show this message
            --version                    Show version

    Commands: start, stop, restart

## Caveats

* Truly prototype code, but I wanted to get it out there.
* This doesn't exactly work for Rails yet, because it expects a config.ru

## TODO

* TEST
* Make `configure` command akin to mongrel_rails cluster::configure

## License

Copyright (c) 2009 Ryan Carmelo Briones &lt;<ryan.briones@brionesandco.com>&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
