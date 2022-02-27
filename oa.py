# oa.py - Core Open Assistant Loop

import signal
from gi.repository import GLib
from core import Assistant

if __name__ == '__main__':
    # Create Assistant
    assistant = Assistant()

    # Create Main Loop
    main_loop = GLib.MainLoop()

    # Handle Signal Interrupts
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    # Run Assistant
    assistant.run()

    # Start Main Loop
    try:
        main_loop.run()

    except:
        main_loop.quit()
        sys.exit()
        
