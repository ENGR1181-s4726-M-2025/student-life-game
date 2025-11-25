#!/bin/sh
cd "$(dirname $0)"
python3 assets/compile.py
python3 maps/generate.py maps/engineering_core.png sprites
python3 maps/generate.py maps/engineering_core_colliders.png colliders
