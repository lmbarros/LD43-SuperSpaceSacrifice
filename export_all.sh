#!/bin/sh

TARGETS="HTML5 Linux32 Linux64 Windows32 Windows64 Mac"
GAME_NAME=LD43-Xxxxxxxxxxxxx

mkdir export

for t in $TARGETS; do
    mkdir -p export/$t
    rm -f export/$t/*
#    godot src/project.godot --export $t $GAME_NAME
#    mv src/$GAME_NAME* export/$t
done

godot src/project.godot --export HTML5 export/HTML5/index.html
godot src/project.godot --export Linux32 export/Linux32/$GAME_NAME
godot src/project.godot --export Linux64 export/Linux64/$GAME_NAME
godot src/project.godot --export Windows32 export/Windows32/$GAME_NAME.exe
godot src/project.godot --export Windows64 export/Windows64/$GAME_NAME.exe
godot src/project.godot --export Mac export/Mac/$GAME_NAME.app
