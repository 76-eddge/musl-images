param($Arch)

$Environment

Switch ($Arch) {
	"x86_64" {$Environment = "x86_64-linux-musl"}
	"aarch" {$Environment = "aarch64-linux-musl"}
	"arm" {$Environment = "arm-linux-musleabihf"}
	"i686" {$Environment = "i686-linux-musl"}
	"powerpc64le" {$Environment = "powerpc64le-linux-musl"}
	default {throw "Invalid architecture selection"}
} 

New-Item -Path "/opt/$Environment-cross" -ItemType "Directory" -Force
tar -xf "/tmp/$Environment.tar.xz" -C "/opt/$Environment-cross"

$env:PATH = "/opt/$Environment-cross/bin:" + $env:PATH
# TODO: Do we need to add any includes here for the default search path?
$env:CPATH = ""
$env:CXX = "$Environment-g++"