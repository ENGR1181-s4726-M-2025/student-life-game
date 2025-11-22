# This script attempts to resolve the colors in the source map PNGs into the
#   actual values that will live in the spritemap and the collidermap of each
#   world.
# Resolving colliders is trivial - we just use the RGB color of the pixel as
#   the ID of that collider type. The only thing we have to do is generate a .m
#   file associating a name with each magic value, similar to what 
#   assets/compile.py does. 
# Compiling assets is a bit harder. There are a number of 'sprite classes', or
#   pixel colors, that represent multiple sprites in the ultimate spritemap,
#   for example because we want to randomly pick one of the sprites of tiling
#   large areas (e.g. grass), or it has to connect with sprites next to it (e.g.
#   walls).
# Performing that selection logic in this file rather than at runtime saves a
#   huge amount of effort overall, though.


from spritemap import *
from bldgmap import *

ridx = lambda x: randint(0, x - 1)

# Colors from the image are too large to reasonably use as spritesheet indices.
# Otherwise, that would have been way nicer...
def spritemap(rgb: int) -> int:
    match (rgb):

        # road
        case 0x3f3f3f:
            return MISSING
            """
            return ROAD
            """

        # grass
        case 0x3fbf3f:
            return GRASS0
            """
            return [GRASS_0, GRASS_1, GRASS_2, GRASS_#](ridx(4))
            """
        # tree
        case 0x3f7f3f:
            return MISSING
            """
            return [TREE_0, TREE_1, TREE_2](ridx(3))
            """

        # building
        case 0xffcf7f:
            return MISSING
            """
            n, s, w, e, nw, ne, sw, se = (
                
            )
            """

        # 

        case _:
            return MISSING

colliders = {
        0x007fff:   "NORTH"
        0x007ffe:   "KNOWLTON_HALL"
        0x007ffd:   "ENARSON_CLASSROOM_BLDG"
        0x007ffc:   "MCCRACKEN_POWER_PLANT"
        0x007ffb:   "DREESE_LABS"
        0x007ffa:   "BAKER_SYSTEMS"
        0x007ff9:   "HITCHCOCK_HALL"
        0x007ff8:   "BOLZ_HALL"
        0x007ff7:   "CALDWELL_LABS"
        0x007ff6:   "JOURNALISM_BLDG"
        0x007ff5:   "COCKINS_HALL"
        0x007ff4:   "MATHEMATICS_BLDG"
        0x007ff3:   "MATHEMATICS_TOWER"
        0x007ff2:   "SCOTT_LABS"
        0x007ff1:   "PHYSICS_RESEARCH_BLDG"
        0x007ff0:   "X_209_W_18TH"
        0x007fef:   "X_18TH_AVE_LIBRARY"
        0x007fee:   "SMITH_LABS"
        0x007fed:   "CBEC"
        0x007fec:   "FONTANA_LAB"
        0x007feb:   "MCPHERSON_LAB"
        0x007fea:   "CELESTE_LAB"
        0x007fe9:   "STILLMAN_HALL"
        0x007fe8:   "OXLEYS"
}



def collidermap(rgb: int) -> int:
    try:
        return colliders[rgb]
    except:
        return 0

