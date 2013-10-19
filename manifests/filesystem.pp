class cli::filesystem inherits cli::params {
	package {'ntfs-3g':}
	package {'xfsprogs':}
	package {'exfat-utils':}
    package {'fuse-exfat':}
	package {'e2fsprogs':}
}
