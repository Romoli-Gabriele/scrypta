#/bin/bash
# Run berkley.sh
# sudo bash berkley.sh
# Run boost.sh


# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
sudo apt-get update
sudo apt-get install -y software-properties-common python-software-properties
sudo apt-get install -y build-essential autoconf automake libleveldb-dev libgmp-dev libgmp3-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev autogen libtool git libevent-dev libprotobuf-dev
sudo apt-get install -y curl g++ git-core pkg-config libtool faketime bsdmainutils mingw-w64 g++-mingw-w64 nsis zip ca-certificates python
sudo apt-get install -y libzmq3-dev
sudo apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
sudo apt-get install -y libqrencode-dev
sudo apt-get install -y sudo apt-get install libssl1.0-dev --no-remove

# Check if scrypta directory exists
if [ ! -d "scrypta" ]; then
    echo "Cloning LYRA repository..."
    git clone https://github.com/Romoli-Gabriele/scrypta
    cd scrypta
    chmod 777 ltmain.sh
else
    echo "LYRA directory already exists. Skipping clone."
    cd scrypta
    git pull
fi
./autogen.sh
./configure --with-boost=/usr/local
# Do make only if configure is successful
if [ $? -eq 0 ]; then
    sudo make install
    mkdir /root/.lyra
    touch /root/.lyra/lyra.conf
    echo "fill in the lyra.conf file then run: lyrad &"
fi