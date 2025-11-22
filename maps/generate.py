#!/usr/bin/python3
# vim: sw=4 sts=4 ts=4 et
from os import path
from sys import argv

from PIL import Image

from colormap import colormap

try:
    if not argv[1].endswith(".png"):
        raise ValueError("File improper")

except:
    print("usage:", __file__, "<file.png>")
    exit()


script_dir = path.dirname(__file__);
world_map_path = path.join(
    #path.dirname(path.realpath(script_dir)),
    script_dir,
    "%s.sprites.csv" % argv[1][:-4]
)

im = Image.open(argv[1])
w, h = im.size

with open(world_map_path, "w") as wm:#, open(collider_map_path, "w")
    for y in range(h):
        row = []

        for x in range(w):
            r, g, b, _ = im.getpixel((x, y))
            rgb = (r << 16) + (g << 8) + b
            
            row.append("%d" % colormap(rgb))

        print(",".join(row), file=wm)
