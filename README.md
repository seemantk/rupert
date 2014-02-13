rupert
======

A [cinch bot](https://github.com/cinchrb/cinch) plugin to interface with [BufferApp's API](https://bufferapp.com/developers/api/). At the moment, the only two commands it obeys are:
 * **!profiles** changes the channel topic to list all the profiles connected to your [BufferApp](https://bufferapp.com) account and some statistics.
 * **!post <msg>** adds <msg> to your [BufferApp](https://bufferapp.com) queue.  The topic then will automatically refresh with updated account stats & info.

## Requirements ##

To run this, you need to first install [cinch](https://github.com/cinchrb) and [buff](https://github.com/zph/buff):

    gem install cinch buff

Since this is all in [ruby](http://ruby.org), I recommend using ruby and gems and all that stuff with [rvm](http://rvm.io).

## Pre-Installation ##

The best way to run this bot is on a small, lightweight irc server listening only on localhost.  You can try [ngircd](http://ngircd.barton.de): lightweight and really easy to install, configure & run.  Connnect to that server with an irc client ([pidgin](http://pidgin.im/), [hexchat](http://hexchat.github.io), [quassel](http://quassel-irc.org) and [irssi](http://irssi.org) are popular choices) and create a channel that you will use to interact with Rupert.  For example:

    /join #bufferapp

## Installation ##

Clone this repository.  Follow github's instructions up there.

## Configuration ##

Edit `lib/cinch/plugins/rupert.rb` and replace `YOURKEYHERE` with the your [Buffer App access token](https://bufferapp.com/developers/apps).  (Please keep the double-quote marks).

The top-level directory `rupert.rb` contains the IRC connection information. The following things can be replaced:
 * `127.0.0.1` with your irc server--if you change it, I hope it's on a secure vpn at least.
 * `#bufferapp` with the name of your irc channel.
 * `rupert` (`c.nick: rupert`) with whatever else you want to name the bot.

## Running It ##

From the top-level directory, run

    ruby rupert.rb
    
`Ctrl C` exits.
 
    
I don't know yet how to make this a proper installable cinch plugin, as cinch is just the quick proof of concept.
