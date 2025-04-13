import os
import time

def fdpath(fd):
    return f'/proc/{os.getpid()}/fd/{fd}'

def fdpaths(fds):
    r, w = fds
    return (fdpath(r), fdpath(w))

"""
herestring equivalent in xonsh, e.g.
 with std.here('hello world') as x:
   ![cat @(x)]
"""
class here:

    def __init__(self, bytes):
        if isinstance(bytes, str):
            self.bytes = bytes.encode('utf-8')
        else:
            self.bytes = bytes

    def __enter__(self):
        r, w = os.pipe()
        os.write(w, self.bytes)
        os.close(w)
        self.r = r
        return fdpath(r)

    def __exit__(self, exc_type, exc_value, traceback):
        os.close(self.r)
        return False

