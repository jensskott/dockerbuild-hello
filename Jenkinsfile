def projectName = "dockerbuild-hello"
def projectOwner = "jensskott"
def binary = "dockerbuild-hello"

node('chef') {

    git url: 'git@github.com:jensskott/dockerbuild-hello.git'

    tool name: 'Default', type: 'git'

    step([$class: 'WsCleanup'])

    stage('checkout repo') {
        checkout scm
    }
    
    stage('Build artifact') {
        sh """!#/bin/bash
        docker build --build-arg project_name=${projectName} --build-arg project_owner=${projectOwner} -t ${projectName}-build -f Dockerfile-build .
        mkdir build
        docker run -i -t -v `pwd`/build:/opt ${projectName}-build
        """
    }
    
    stage('Build docker image') {
        sh """#!/bin/bash
        set -e
        docker build --build-arg binary=${binary} -t ${projectName}:latest .
        """
    }
    
    stage('List image') {
        sh "docker images | grep ${projectName}"
    }
}