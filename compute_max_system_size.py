#!/usr/bin/env python3

from math import sqrt
import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-d-','--delta')
parser.add_argument('-k-','--kappa')

args = parser.parse_args()

print(sqrt((1-float(args.delta))/(float(args.kappa))))
