import ctypes
import sys


def say(message, libc):
    b = ctypes.ARRAY(ctypes.c_char, len(message))(*(ord(m) for m in message))
    f = libc.syscall
    f.argtypes = (
    ctypes.c_long,
    ctypes.c_long,
    ctypes.POINTER(ctypes.c_char),
    ctypes.c_long)
    f(64, 1, b, len(message))


def read(libc):
    b = ctypes.ARRAY(ctypes.c_char, 256)()
    f = libc.syscall
    f.argtypes = (
        ctypes.c_long,
        ctypes.c_long,
        ctypes.POINTER(ctypes.c_char),
        ctypes.c_long
    )
    f(63, 0, b, 256)
    s = b.raw.decode('utf_16le').rstrip('\x00')
    return s

def main(args):
    libc = ctypes.CDLL(None)
    if args[0] == "echo":
        if len(args) < 2:
            return
        say(args[1] + "\n", libc)
    elif args[0] == "cat":
        if len(args) < 2:
            return
        if len(args) == 2:
            say(args[1] + "\n", libc)
        while True:
            try:
               text = read(libc)
               print("t: " + text)
               say(text + "\n", libc) 
            except KeyboardInterrupt:
                exit(0)
    

if __name__ == "__main__":
    args = [sys.argv[i] for i in range(1,len(sys.argv))]
    main(args)


