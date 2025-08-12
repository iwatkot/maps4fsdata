<p align="center">
<a href="https://github.com/iwatkot/maps4fs">maps4fs</a> •
<a href="https://github.com/iwatkot/maps4fsui">maps4fs UI</a> •
<a href="https://github.com/iwatkot/maps4fsdata">maps4fs Data</a> •
<a href="https://github.com/iwatkot/maps4fsapi">maps4fs API</a> •
<a href="https://github.com/iwatkot/maps4fsstats">maps4fs Stats</a> •
<a href="https://github.com/iwatkot/maps4fsbot">maps4fs Bot</a><br>
<a href="https://github.com/iwatkot/pygmdl">pygmdl</a> •
<a href="https://github.com/iwatkot/pydtmdl">pydtmdl</a>
</p>

<div align="center" markdown>

<img src="https://github.com/iwatkot/maps4fsui/releases/download/2.2.3/maps4fs-poster_dev5.png">

<p align="center">
    <a href="#maps4fs">Maps4FS</a> •
    <a href="#data-files">Data Files</a>
</p>
</div>

# Maps4FS

Maps4FS is a tool for automatic generation maps for Farming Simulator games using the real world data. More information can be found in the [main repository](https://github.com/iwatkot/maps4fs).  

This repository contains data files: map templates, texture, GRLE, and trees schemas.

## Data Files

The data is splitted in separate folders for each supported game: `fs22` for Farming Simulator 22, `fs25` for Farming Simulator 25, and so on.  
The directory contains all the necessary (and supported) files for each game.  

- Map Template *
- Texture schema *
- GRLE schema
- Trees schema  

_The map template and texture schema are required for the map generation, other components are optional._

### Map template

**Required:** Yes  
**Path:** `/game_code/<game_code>-map-template`  

The map template contains all the files, that required for the mod to be functional in the game after the generation process. It contains a lot of different files and it's not recommended to modify it manually without deep knowledge of the game's modding system.

### Texture schema

**Required:** Yes  
**Path:** `/game_code/<game_code>-texture-schema.json`  

Contains all the required information about the textures, that will be used for the generation.  
Learn more about the texture schema in the [documentation](https://github.com/iwatkot/maps4fs?tab=readme-ov-file#Texture-schema).

### GRLE schema

**Required:** No  
**Path:** `/game_code/<game_code>-grle-schema.json`  

Contains all the required information about the GRLE files, that will be used for the generation. Should not be modified manually.

### Trees schema

**Required:** No  
**Path:** `/game_code/<game_code>-tree-schema.json`  

Contains all the required information about the trees, that will be used for the generation. Can be modified manually referring to the default schema. Learn more about the tree schema in the [documentation](https://github.com/iwatkot/maps4fs?tab=readme-ov-file#schemas-editor).