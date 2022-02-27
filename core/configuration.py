# configuration.py - Open Assistant Configuration

import os
import re
import json
from argparse import ArgumentParser, Namespace

class Configuration:
    """OA Configuration"""
    
    # Setup Directories
    mind_dir = os.environ['MINDDIR']
    ability_dir = os.path.join(mind_dir, 'abilities')
    lang_dir = os.path.join(mind_dir, 'language')

    # Command File
    cmd_file = os.path.join(ability_dir, "commands.json")

    # Language Model Files
    strings_file = os.path.join(lang_dir, "commands.txt")
    lang_file = os.path.join(lang_dir, 'language-model')
    dic_file = os.path.join(lang_dir, 'dictionary')
    history_file = os.path.join(lang_dir, "history")
    hash_file = os.path.join(lang_dir, "hash.json")

    def __init__(self):

        # Set Up Argument Parser
        self._parser = ArgumentParser()

        self._parser.add_argument("-c", "--continuous",
                action="store_true", dest="continuous", default=False,
                help="Start interface with 'continuous' listen enabled")

        self._parser.add_argument("-p", "--pass-words",
                action="store_true", dest="pass_words", default=False,
                help="Pass the recognized words as arguments to the shell" +
                " command")

        self._parser.add_argument("-H", "--history", type=int,
                action="store", dest="history",
                help="Number of commands to store in history file")

        self._parser.add_argument("-m", "--microphone", type=int,
                action="store", dest="microphone", default=None,
                help="Audio input card to use (if other than system default)")

        self._parser.add_argument("--valid-sentence-command", type=str,
                dest="valid_sentence_command", action='store',
                help="Command to run when a valid sentence is detected")

        self._parser.add_argument("--invalid-sentence-command", type=str,
                dest="invalid_sentence_command", action='store',
                help="Command to run when an invalid sentence is detected")

        # Read The Configuration File
        self._read_options_file()

        # Parse Command-line Arguments, Overriding Config File As Appropriate
        self._parser.parse_args(namespace=self.options)

    def _read_options_file(self):
        try:
            with open(self.cmd_file, 'r') as f:
                self.options = json.load(f)
                self.options = Namespace(**self.options)
        except FileNotFoundError:
            # MAke An Empty Options Namespace
            self.options = Namespace()
