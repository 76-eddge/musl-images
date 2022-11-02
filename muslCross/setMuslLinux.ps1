param($Arch)

$Environment
$Version = "11.3.0"

Switch ($Arch) {
	"x86_64" {$Environment = "x86_64-linux-musl"}
	"aarch" {$Environment = "aarch64-linux-musl"}
	"arm" {$Environment = "arm-linux-musleabihf"}
	"i686" {$Environment = "i686-linux-musl"}
	"powerpc64le" {$Environment = "powerpc64le-linux-musl"}
	default {throw "Invalid architecture selection. Valid selections : x86_64, aarch, arm, i686, powerpc64le"}
} 
$env:LIBRARY_PATH= "/opt/${Environment}/lib/${Environment}/${Version}:/opt/${Environment}/${Environment}/lib:" + $env:LIBRARY_PATH
$env:LD_LIBRARY_PATH= "/opt/${Environment}/lib/${Environment}/${Version}:/opt/${Environment}/${Environment}/lib:" + $env:LD_LIBRARY_PATH
$env:PATH = "/opt/${Environment}/bin:" + $env:PATH
# TODO: Do we need to add any includes here for the default search path?
# $env:CPATH = "/opt/${Environment}/${Environment}/include"
$env:CXX = "${Environment}-g++"
$env:CC = "${Environment}-gcc"