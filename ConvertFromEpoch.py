import datetime
import os.path

# inputFile
infile='./date.txt'

# epoch time (1970,1,1 or 1601,1,1 or whatever system you are looking at)
epoch_start=datetime.datetime(1601,1,1)


def date_from_webkit(webkit_timestamp):
    delta = datetime.timedelta(microseconds=int(webkit_timestamp))
    print(epoch_start + delta)

check_file = os.path.isfile(infile)
if check_file:
    with open(infile) as file:
        while line := file.readline():
            date_from_webkit(line)
else:
    print('Source File '+infile+' missing')