
#!/bin/bash


function print_normal
{
    echo $1
}

function print_special
{
    echo -e '\033[40;32m'
    echo $1
    echo -e '\033[40;37m'
}

function print_warnning
{
    echo -e '\033[40;31m'
    echo $1
    echo -e '\033[40;37m'
}


#######################################################################
# begin

function start_docker
{
    print_normal 'start docker'
    systemctl start docker
}

function run_docker_hello_world
{
    print_normal 'docker run hello world.'
    docker run hello world
}

function build_node_image
{
    print_special 'build new image for lanshuo-nodejs.'
    pwd
    cd node/
    mkdir ./build/
    docker build -t lanshuo-nodejs .
}

function build_nodeapp_image
{
    print_special 'build new image for lanshuo-nodejs-appdemo:8000.'
    pwd
    cd web/
    mkdir ./build/
    docker build -t lanshuo-nodejs-appdemo .
    docker run --name appdemo -d -p 80:8000 lanshuo-nodejs-appdemo
}

function run_web_demo_app
{
    print_normal 'prepare the index.js. cp the file to dest path.'
    if [ -f ./index.js ];
    then {
        cp index.js /var/nodejs/index.js
    }
    else
        {
            print_warnning 'can not fine the index.js'
        }
    fi

}

#######################################################################################
start_docker
run_docker_hello_world

build_node_image
build_nodeapp_image
