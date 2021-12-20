import hifive
import sys

hic=hifive.HiC(sys.argv[2],'w')

hic.load_data(sys.argv[1])

hic.save()