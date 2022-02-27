# core.py - Open Assistant Core

import os
import sys
from .recognizer import Recognizer
from .configuration import Configuration

class Assistant:
    """ Build Assistant """

    def __init__(self):
        self.options = {}
        self.continuous_listen = True

        # Load Configuration
        self.config = Configuration()
        self.options = vars(self.config.options)
        self.commands = self.options['commands']
        
        # Optional: History
        if self.options['history']:
            self.history = []

        # Create Speech Recognizer
        self.recognizer = Recognizer(self.config)
        self.recognizer.connect('finished', self.recognizer_finished)

    def create_strings_file(self):
        # Open Strings File
        with open(self.config.strings_file, 'w') as strings:
            # Add Command Words To The Corpus
            for voice_cmd in sorted(self.commands.keys()):
                strings.write(voice_cmd.strip().replace('%d', '') + "\n")

    def log_history(self, text):
        if self.options['history']:
            self.history.append(text)
            if len(self.history) > self.options['history']:
                # Pop Off First Item
                self.history.pop(0)

            # Open And Truncate History File
            with open(self.config.history_file, 'w') as hfile:
                for line in self.history:
                    hfile.write(line + '\n')

    def run_command(self, cmd):
        """ Print Command And Run """
        print("\x1b[32m< ! >\x1b[0m", cmd)

        self.recognizer.pause()
        os.system(cmd)
        self.recognizer.listen()

    def recognizer_finished(self, recognizer, text):
        t = text.lower()

        # Test For A Matching Command
        if t in self.commands:
            # Run 'valid_sentence_command' If Set
            os.system('clear')
            print("Stella: \x1b[32mSpeaking\x1b[0m")

            if self.options['valid_sentence_command']:
                os.system(self.options['valid_sentence_command'])

            cmd = self.commands[t]

            # Should We Be Passing Words?
            os.system('clear')
            print("Stella: \x1b[32mSpeaking\x1b[0m")

            if self.options['pass_words']:
                cmd += " " + t
            print("\x1b[32m< ! >\x1b[0m {0}".format(t))

            self.run_command(cmd)
            self.log_history(text)
        
        else:
            # Run The Invalid_sentence_command If Set
            if self.options['invalid_sentence_command']:
                subprocess.call(self.options['invalid_sentence_command'],
                                shell=True)
            print("\x1b[31m< ? >\x1b[0m {0}".format(t))

    def run(self):
        self.recognizer.listen()

    def quit(self):
        sys.exit()

    def process_command(self, command):
        print(command)
        if command == "listen":
            self.recognizer.listen()
        elif command == "stop":
            self.recognizer.pause()
        elif command == "continuous_listen":
            self.continuous_listen = True
            self.recognizer.listen()
        elif command == "continuous_stop":
            self.continuous_listen = False
            self.recognizer.pause()
        elif command == "quit":
            self.quit()
