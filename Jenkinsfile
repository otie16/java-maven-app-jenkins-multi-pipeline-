#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/otie16/jenkins-shared-library.git',
     credentialsId: 'github-credentials'
    ]
)

pipeline{
    agent any
    tools {
        maven 'maven-3.9'
    }
    environment {
        IMAGE_NAME = 'otobongedoho18361/demo-app:java-maven-2.0'    
    }
    stages{
        stage('build app'){
            steps{
                script{
                    echo 'building application jar...'
                    buildJar()
                }
            }
        }
        stage('build image'){
            steps{
                script{
                    echo 'building the docker image...'
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)
                }
            }
        }
        stage('deploy'){
            steps{
                script{
                    echo 'deploying docker image to EC2...'

                    // def dockerCommand = "docker run -p 8080:8080 -d ${IMAGE_NAME}"
                    // def dockerComposeCmd = "docker-compose -f docker-compose.yaml up --detach"
                    // Passing the image name as a parameter to the shell script file
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                    def ec2Instance = "ec2-user@52.55.209.78"
                    
                    sshagent(['ec2-server-key']) {
                       sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
                       sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                       sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
                    }
                    // echo 'Deploying the application'
                    // echo "Executing pipeline for branch BRANCH_NAME"
                }
            }
        }
    }
}
