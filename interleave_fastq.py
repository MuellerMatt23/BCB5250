#!/usr/bin/env python3
import argparse
from Bio import SeqIO

def interleave_fastq(forward_file, reverse_file, output_file):
    try:
        # open the files
        with open(forward_file, 'r') as forward_reads, open(reverse_file, 'r') as reverse_reads, open(output_file, 'w') as interleaved_reads:
          # use a for loop with the zip() function to read the pairs of reads. SeqIO.parse will parse each fastq file
          for forward_read, reverse_read in zip(SeqIO.parse(forward_reads, 'fastq'), SeqIO.parse(reverse_reads, 'fastq')):
            # write the forward read to the output file
            SeqIO.write(forward_read, interleaved_reads, 'fastq')
            # write the reverse read to the output file
            SeqIO.write(reverse_read, interleaved_reads, 'fastq')
    # raise exception if one or more of the files are not found
    except FileNotFoundError:
        print("Error: File Not Found.")
    # raise an exception if one or more of the files are not in fastq format
    except ValueError:
        print("File not in FASTQ format."
        


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Interleave Paired-End FASTQ Files')
    parser.add_argument('forward_file', help='Forward reads FASTQ file')
    parser.add_argument('reverse_file', help='Reverse reads FASTQ file')
    parser.add_argument('output_file', help='Output interleaved FASTQ file')
    args = parser.parse_args()
    interleave_fastq(args.forward_file, args.reverse_file, args.output_file)
