# Battleship

http://soloman-battleship.herokuapp.com


## Introduction

This simple tiny battle ship game app was quickly hacked up over the weekend for fun and practice purposes. It is currently at a very beta stage, and the game itself is not fun at all and still requires a lot of works.

The initial version was built utilising following:

* Treiv (https://github.com/maccman/trevi): generator for building an opinionated Sinatra structure.
* D3.js
* Borrowed some idea from (http://snips.net/blog/posts/2014/01-10-fast-interactive_prototyping_with_d3_js.html), utilising Sketch App to create nice looking SVG app template. 


A running example of this app can be found at: http://soloman-battleship.herokuapp.com
Please note, it is expected that the current version performing kinda slow as the svg file wasn't really optimised and each individual click action generates a ajax request (in real world, app like this should have gaming logic built in front end~).


## Installation

To install this app locally, please do:

```bash

  git clone git@bitbucket.org:soloman1124/battleship.git

  cd battleship  

  bundle install

```

## Running the App

To run this app locally, simply do:

```bash

  rackup -p 9999

```

Then the app can be accessed at `localhost:9999` through Chrome/Safari/Firefox (IE is untested :P ).


## Tests

I tried to do as much TDD as possible while making this :P. To run the available spec tests, simply do:

```bash

  bundle exec rake spec

```



## Screenshot

![Snip20140504_1.png](https://bitbucket.org/repo/4Mzxr9/images/1797548847-Snip20140504_1.png)

Have fun!
