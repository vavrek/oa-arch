#!/usr/bin/env python

# news-tech.py - Read Reddit Technology News Headlines

import subprocess
import feedparser
import string

rss = feedparser.parse('http://www.reddit.com/r/technology/.rss')

print(rss['feed']['title'])

subprocess.call("echo Reading Technology news... | $VOICE", shell=True)

for post in rss.entries:
  headline = post.title
  exclude = set(string.punctuation)
  headline = ''.join(ch for ch in headline if ch not in exclude)
  subprocess.call("echo \"" + headline + "\n\" | tee /dev/tty | $VOICE", shell=True)
