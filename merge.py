# -*- coding: utf-8 -*-
#!/usr/bin/env python3
import os
import sys
if __name__ == '__main__':
    print('ESPhaku by Yoti')
    if not os.path.exists('esphaku.bin'):
        print('esphaku.bin not found')
        sys.exit()
    if not os.path.exists('esphaku.ffs'):
        print('esphaku.ffs not found')
        sys.exit()
    with open('esphaku.bin', 'rb') as bin:
        bin_read = bin.read()
        if len(bin_read) > 0x100000:
            print('esphaku.bin is too large')
            sys.exit()
        with open('esphaku.ffs', 'rb') as ffs:
            ffs_read = ffs.read()
            if len(ffs_read) > 0x300000:
                print('esphaku.ffs is too large')
                sys.exit()
            with open('esphaku.full.bin', 'wb') as out:
                out.write(bin_read)
                out.write(b'\0' * (0x100000 - len(bin_read)))
                out.write(ffs_read)
                out.write(b'\0' * (0x300000 - len(ffs_read)))
                print('Done with success')