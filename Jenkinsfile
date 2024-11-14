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
     stage('increment version') {
            steps {
                script {
                    echo 'incrementing app version...'
                    sh 'mvn build-helper:parse-version versions:set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        versions:commit'
                    def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = matcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }
            }
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
        stage('commit version update') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        // git config here for the first time run
                        // sh 'git config --global user.email "biggieestone@gmail.com"'
                        // sh 'git config --global user.name "otie16"'
                        sh "git remote set-url origin https://${USER}:${PASS}@github.com/otie16/java-maven-app-jenkins-multi-pipeline-.git"
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:jenkins-jobs'
                    }
                }
            }
    }
}
