#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'bob'
Bob.root # cache root dir
Grit.debug = true
Bob.run
