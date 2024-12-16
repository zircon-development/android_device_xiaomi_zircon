#!/usr/bin/env python

import argparse
from os import stat


def padding_file(input_file, align_num):
    """Fill 0 to make input_file's size a multiple of align_num."""
    filesize = stat(input_file).st_size
    with open(input_file, 'ab+') as file1:
        padding = filesize % align_num
        if padding != 0:
            padding = align_num - padding
            file1.write(b"\x00" * padding)


def append_file(img_file, file_to_append, alignment):
    """Append provided file_to_append to the end of target img_file."""
    padding_file(img_file, alignment)
    with open(img_file, 'ab+') as file1, open(file_to_append, 'rb') as file2:
        file1.write(file2.read())


def main():
    parser = argparse.ArgumentParser(description='Sign an image with provided der certs')
    parser.add_argument('--alignment', type=int, help='Alignment for calculating padding')
    parser.add_argument('--cert1', type=str, help='Certificate - cert1.der')
    parser.add_argument('--cert2', type=str, help='Certificate - cert2.der')
    parser.add_argument('--encrypted_data', type=str, help='Encrypted Data - encrypted_data.bin')
    parser.add_argument('--dtbo', type=str, help='Path to the DTBO img')
    args = parser.parse_args()

    # Append encrypted data first
    append_file(args.dtbo, args.encrypted_data, args.alignment)

    # Then append certificates
    append_file(args.dtbo, args.cert1, args.alignment)
    append_file(args.dtbo, args.cert2, args.alignment)


if __name__ == '__main__':
    main()
