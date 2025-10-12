import ctypes
import signal
import time 
import sys

def cin(message = None):
    libc = ctypes.CDLL(None)

    if message:
        # display message 
        b = ctypes.ARRAY(ctypes.c_char, len(message))(*(ord(m) for m in message))
        f = libc.syscall
        f.argtypes = (
        ctypes.c_long,
        ctypes.c_long,
        ctypes.POINTER(ctypes.c_char),
        ctypes.c_long)
        f(64, 1, b, len(message))


    b = ctypes.ARRAY(ctypes.c_char, 256)()
    f = libc.syscall
    f.argtypes = (
        ctypes.c_long,
        ctypes.c_long,
        ctypes.POINTER(ctypes.c_char),
        ctypes.c_long
    )
    n = f(63, 0, b, 256)
    s = "".join([chr(b[i][0]) for i in range(n)])
    return s

def sig_int_handler(sig, frame):
    ans = cin("\nDo you reaaaally want to quit ? (Y / N)")
    print("answer : " + ans)
    if ans.lower().strip() == "y":
        exit(0)
    
        

def sig_timeout_handler(sig, frame):
    print("Sorry too much time has passed !")
    exit(0)

def fibo_plus():
    fibo_numbers = [0,1]
    while True:
        input()
        sum = fibo_numbers[-1] + fibo_numbers[-2]
        fibo_numbers.append(sum)
        print(sum)
                


if __name__ == "__main__":
    signal.signal(signal.SIGINT, sig_int_handler)
    signal.signal(signal.SIGALRM, sig_timeout_handler)
    signal.alarm(60)
    fibo_plus()
