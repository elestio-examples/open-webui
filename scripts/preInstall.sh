#set env vars
set -o allexport; source .env; set +o allexport;

lshw_output=$(lshw)

if [[ $lshw_output == *nvidia* ]]; then
    nvidia-smi -pm 1
    echo "Installing the GPU version..."
    sed -i 's/#deploy:/deploy:/g' ./docker-compose.yml
    sed -i 's/#  resources:/  resources:/g' ./docker-compose.yml
    sed -i 's/#    reservations:/    reservations:/g' ./docker-compose.yml
    sed -i 's/#      devices:/      devices:/g' ./docker-compose.yml
    sed -i 's/#        - driver: nvidia/        - driver: nvidia/g' ./docker-compose.yml
    sed -i 's/#          count: all/          count: all/g' ./docker-compose.yml
    sed -i 's/#          capabilities: \[gpu\]/          capabilities: \[gpu\]/g' ./docker-compose.yml
    
    sed "s/^SOFTWARE_VERSION_TAG=.*/SOFTWARE_VERSION_TAG=cuda/" .env
else
    echo "Installing the CPU version..."
fi