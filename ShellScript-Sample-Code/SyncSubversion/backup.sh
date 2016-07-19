echo "Starting-------"
date
echo "Starting checkout branches-------"
#./checkout-branches.sh
date
echo "Starting svn update-------"
./update-branches.sh
date
echo "Starting tar files-------"
./tar.sh
date
echo "Ending-------"
