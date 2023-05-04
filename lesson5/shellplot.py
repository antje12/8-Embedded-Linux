from uniplot import plot
import sys

# read a list of numbers from stdin
for line in sys.stdin:
    lst = line.rstrip().split(",")

# convert a list of strings to a list of floats
lst_num = list(map(float, lst))

# plot the float numbers
plot(lst_num, lines=True)
