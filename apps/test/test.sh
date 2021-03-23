SCRIPT_PATH=$(realpath ${BASH_SOURCE})

sudo rm -f $SCRIPT_PATH

echo "Welcome to the test app!"

wget https://github.com/CypherpunkArmory/UserLAnd-Assets-Ubuntu/releases/download/v7.7.7/SmokeTest.class

chmod 777 SmokeTest.class

java SmokeTest

sleep 5
