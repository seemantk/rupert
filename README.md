rupert
======

A [cinch bot](https://github.com/cinchrb/cinch) plugin to interface with [BufferApp's API](https://bufferapp.com/developers/api/). At the moment, the only two commands it obeys are:
 * **!profiles** lists all the profiles you have connected to your [BufferApp](https://bufferapp.com) account.
 * **!post <msg>** adds <msg> to your [BufferApp](https://bufferapp.com) queue

## Requirements ##

To run this, you need to first install [cinch](https://github.com/cinchrb) and [buff](https://github.com/zph/buff):

    gem install cinch buff

Since this is all in [ruby](http://ruby.org), I recommend using ruby and gems and all that stuff with [rvm](http://rvm.io).

## Pre-Installation ##

The best way to run this bot is on a small, lightweight irc server listening only on localhost.  You can try [ngircd](http://ngircd.barton.de): lightweight and really easy to install, configure & run.  Connnect to that server with an irc client ([pidgin](http://pidgin.im/), [hexchat](http://hexchat.github.io) and [irssi](http://irssi.org) are popular choices) and create a channel that you will use to interact with Rupert.  For example:

    /join #bufferapp

## Installation ##

Clone this repository.  Follow github's instructions up there.

## Configuration ##

You will need to edit two files named `rupert.rb`.  Sorry.  

First edit `lib/cinch/plugins/rupert.rb` and replace `YOURKEYHERE` with the your [Buffer App access token](https://bufferapp.com/developers/apps).  (Please keep the double-quote marks).

Now edit `rupert.rb` in the top-level directory. and optionally replace:
 * `127.0.0.1` with your irc server--if you change it, I hope it's on a secure vpn at least.
 * `#bufferapp` with the name of your irc channel.
 * `rupert` (`c.nick: rupert`) with whatever else you want to name the bot.

## Running It ##

From the top-level directory, run

    ruby rupert.rb
    
`Ctrl C` exits.
 
    
I don't know yet how to make this a proper installable cinch plugin, as cinch is just the quick proof of concept.
