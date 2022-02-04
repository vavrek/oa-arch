#!/usr/bin/env python3

# net-test.py - Net Connection Test

import time
import urllib.request, urllib.parse, urllib.error

REMOTE_SERVER = "http://www.speech.cs.cmu.edu"

def is_connected():

  """If Connected Return True, Or Else False"""
  try:
    response=urllib.request.urlopen(REMOTE_SERVER,timeout=3)
    return True
  except urllib.error.URLError as e: pass
  return False

if is_connected():
  print("Internet access is currently available.")
else:
  print("We are offline.")