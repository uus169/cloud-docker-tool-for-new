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



function install_tools
{
    print_special 'install some tools'
    yum -y install yum-utils
    yum makecache fast
    yum -y install tmux

}

function install_docker
{
    which docker
    ret=$?
    if [ $ret -ne 0 ];
    then
        {
            print_warnning 'docker is not installed, start to install docker.'
            curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -
        }
    fi

    print_special 'chmod docker permisssion.'
    usermod -aG docker root
    echo 'start docker'
    systemctl start docker
    systemctl enable docker

}

function run_docker_registry
{
    print_special 'run a private registry'
    docker run -d -p 5000:5000 --name registry registry
}

function run_centos_image
{
    print_special 'pull the new centos'
    docker run -d centos
}

function setup_accelerate
{
    print_special 'set up the accelerate for aliyum'
    if [ -f daemon.json ];
    then
        {
            cp daemon.json /etc/docker/
        }
    else
        print_warnning 'can not find the accelerate config files'
    fi

}

##########################################################################################################
# Begin to init
echo '###################################################################################################'
print_special 'init the cloud server for first time. designed by jacky. 2017.0330'
echo 'setup for centos'
install_tools
install_docker

setup_accelerate
run_docker_registry
run_centos_image
