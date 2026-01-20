[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md)

Homura's Lime Fork
====

This Lime fork was previously used for the Android and iOS ports I provided. Although it is no longer used for those ports, it is still maintained and continues to exist for the Shadow Engine.


License
=======

This Lime fork is licensed under the MIT License. See [LICENSE](LICENSE) for details.


Installation
============

1. Clone the Lime repository:

        haxelib git lime https://github.com/FNF-SE/lime

2. Install required dependencies:

        haxelib git format https://github.com/HaxeFoundation/format 9d69fb342d030fa120d2deafafbbffad248332b8
        haxelib git hxp https://github.com/openfl/hxp b90dee15b5c00e2bd10b86fdfee53f2c1b551e02

3. After cloning see [project/README.md](project/README.md) for details about building native binaries.

4. After any changes to the [tools](tools) or [lime/tools](src/lime/tools) directories, rebuild from source:

        lime rebuild tools

5. To switch away from a source build:

        haxelib set lime [version number]
