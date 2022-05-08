#! /usr/bin/python3

import os
import sys
from pathlib import Path

NOTES = Path('/home/rider/.scripts/notes.txt')


def to_clipboard(text):
    os.system('echo "%s"|xclip -f -r -sel c > /dev/null' % str(text).strip())


def calc_mode(user_input):
    try:
        result = eval(user_input)
        print(user_input)
        to_clipboard(result)
        print(f"\0message\x1f🐍: {result} <i>(copied to clipboard)</i>\n")
        return True
    except Exception:
        return False


def main():
    if not NOTES.exists():
        print(f'{NOTES} does not exist.')
        return
    user_input = sys.argv[1] + '\n' if len(sys.argv) > 1 else None
    if user_input and calc_mode(user_input):
        return

    # Notes
    with open(NOTES) as fp:
        lines = fp.readlines()
    if user_input:
        try:
            deleted = lines.pop(lines.index(user_input))
            to_clipboard(deleted)
        except Exception:
            if '[empty]' not in user_input:
                lines.append(user_input)
        with open(NOTES, 'w') as fp:
            fp.writelines(lines)

    # Display list
    print("\0message\x1f<i>(Type text or a Python expression)</i>\n")
    if lines:
        print('\n'.join(reversed(lines)))
    else:
        print('[empty]')


if __name__ == "__main__":
    main()
