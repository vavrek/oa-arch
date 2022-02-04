#!/usr/bin/env python

# news-world.py - Read Reddit World News Headlines

import subprocess
import feedparser
import string

rss = feedparser.parse('http://www.reddit.com/r/worldnews/.rss')

print(rss['feed']['title'])

subprocess.call("echo Reading World news... | $VOICE", shell=True)

for post in rss.entries:
  headline = post.title
  exclude = set(string.punctuation)
  headline = ''.join(ch for ch in headline if ch not in exclude)
  subprocess.call("echo \"" + headline + "\n\" | tee /dev/tty | $VOICE", shell=True)

