clear; clc;
%%%%% BEGIN CONFIG %%%%%

% TODO: move this into a configuration class

% Path to spritesheet
% :: text
SPRITESHEET = 'assets/sheet.png';

% Size of sprites in spritesheet
% :: (2, 1) {mustBeInteger, mustBePositive}
SPRITE_SIZE = [16, 16];

% Multiply sprite size by this value
% :: (1, 1) {mustBeInteger, mustBePositive}
ZOOM_FACTOR = 2;

%%%%%% END CONFIG %%%%%%

game.StudentLifeGame( ...
    SPRITESHEET, ...
    SPRITE_SIZE, ...
    ZOOM_FACTOR ...
);