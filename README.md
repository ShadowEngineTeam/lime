[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md)

Homura's Lime Fork
====

This Lime fork was previously used for the Android and iOS ports I provided. Although it is no longer used for those ports, it is still maintained and continues to exist for the Shadow Engine.


License
=======

My Lime Fork uses the same [MIT license](LICENSE.md) that OpenFL provides.


Installation
============

1. Clone the Lime repository:

        haxelib git lime https://github.com/HomuHomu833-haxe-stuff/lime

2. Install required dependencies:

        haxelib git format https://github.com/HomuHomu833-haxe-stuff/format
        haxelib git hxp https://github.com/HomuHomu833-haxe-stuff/hxp

3. After cloning see [project/README.md](project/README.md) for details about building native binaries.

4. After any changes to the [tools](tools) or [lime/tools](src/lime/tools) directories, rebuild from source:

        lime rebuild tools

5. To switch away from a source build:

        haxelib set lime [version number]
