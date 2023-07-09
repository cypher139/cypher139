#Cypher139's Build script for OpenRCT2 vita
#still fails to Build
#Last modified: 8-7-22
#for use with Linux Mint 19

#start directory

function installDependencies {
	echo "Checking for Installed Dependencies."
	echo "To install the required system libraries and tools you will need to enter your password for your system package manager below:"
	sudo apt-get install --no-install-recommends -y cmake git build-essential autoconf texinfo bison flex cmake libsdl2-dev libicu-dev gcc pkg-config libjansson-dev libspeex-dev libspeexdsp-dev libcurl4-openssl-dev libcrypto++-dev libfontconfig1-dev libfreetype6-dev libpng-dev libssl-dev libzip-dev build-essential make
	echo "Dependencies Installed"
	sleep 3
}

function repoClone {
	echo "Next Step: Download Project Repositories"
	sleep 3
	cd ~
#	read -p "Press enter to continue"
#	old repo, rebased and may not work
#	git clone -b vita-support https://github.com/angguss/OpenRCT2.git
	git clone https://github.com/devnoname120/OpenRCT2
	git clone https://github.com/DaveeFTW/buildscripts.git
	cd buildscripts/
	git clone https://github.com/DaveeFTW/musl.git
	mkdir build
	cd build/
	mkdir downloads
	cd downloads/
	wget https://fossies.org/linux/misc/old/libelf-0.8.13.tar.gz
	wget https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
	cd ~
	echo "Repositories Downloaded"
	sleep 3
}

function buildSDK {
	echo "Next Step: Build VitaSDK (musl)"
	cd ~
	cd buildscripts/build/
	cmake ..
	make -j4 2>&1 | tee ~/bslog.txt
	cd ~
	echo "VitaSDK (musl) Built"
	sleep 3
}

function buildProduct {
	echo "Next Step: Fix OpenRCT2 Repo Errors"
	cd ~
	cd OpenRCT2/src/openrct2
	sed -i 's/${VITASDK}/$ENV{VITASDK}/' CMakeLists.txt
#	sed -i '/#include <vitasdk.h>/d' diagnostic.c
	cd ..
	cd openrct2-cli
	sed -i 's/${VITASDK}/$ENV{VITASDK}/' CMakeLists.txt
	cd ..
	cd openrct2-ui
	sed -i 's/${VITASDK}/$ENV{VITASDK}/' CMakeLists.txt
	cd ..
	echo "Next Step: Build OpenRCT2"
	export VITASDK=~/buildscripts/build/vitasdk
	export PATH=$VITASDK/bin:$PATH
	cd ~
	cd OpenRCT2/
	mkdir build
	cd build/
	PKG_CONFIG_PATH=~$VITASDK/arm-vita-eabi/lib/pkgconfig CXXFLAGS=-pthread cmake -DVITA=ON -DUSE_MMAP=OFF -DWITH_TESTS=OFF -DDISABLE_HTTP_TWITCH=ON -DDISABLE_NETWORK=ON ..
	make 2>&1 | tee ~/orct2log.txt
	echo "OpenRCT2 Built! Check the build folder for a VPK"
	sleep 3
}

function presentProduct {
	cd ~
	cd OpenRCT2/build
	cp OpenRCT2.vpk ~/Desktop
	echo "I copied the build to your Desktop!"
}

installDependencies
repoClone
buildSDK
buildProduct
presentProduct

#read -p "Press enter to continue"
#erro in dev's script mistake in cmake script
#prepend with ENV
#src/openrct2/CMakeLists.txt:15 (include):
#src/openrct2-cli/CMakeLists.txt:19
#src/openrct2-ui/CMakeLists.txt:15 
 #line 15 change to: include("$ENV{VITASDK}/share/vita.cmake" REQUIRED)
#add to .bashrc and .profile: export PATH="/home/$USER/buildscripts/build/vitasdk/bin:$PATH"