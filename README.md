# Khambe

A port of [Flambe](https://github.com/aduros/flambe/) working in [Kha](https://github.com/KTXSoftware/Kha). This is a work in progess. Khambe has no plans to support canvas. If you looking for canvas support I highly recommend Flambe. This project is looking to support all the native platforms that Kha offers and add additional graphical features while keeping the source outside of platform/kha as original as possible.

### Install
You can install 'khambe' by simply typing in your command line/terminal by inputting
`sudo haxelib git khambe https://github.com/sourcreme/khambe.git`

sudo is used on mac based devices

### Update
Updating is simple. Just point your command line/terminal to the installed location of 'khambe'. which would be something like this [on mac]
`cd /usr/local/lib/haxe/lib/khambe/git`
then input this to update to the latest version
`sudo git submodule foreach --recursive git pull origin master`

### Goals
* Target Android-native
* Target IOS
* Target OSX
* Target WebGL
* Custom Pipelines
* 3D sprites
* Tinting

### Examples
* [Lighting Pipeline](https://github.com/sourcreme/khambe-example)

### Links
[Waffle](https://waffle.io/sourcreme/khambe)

Looking for contributers and criticism.
