#!/user/bin/env groovy

@Library('jenkins-shared-library')
def gv

pipeline {
    agent any
    tools{
        maven 'maven-3.9'
    }
    stages {
        stage('init'){
            steps{
                script{
                   gv = load 'script.groovy'
                }
            }
        }
        stage('build jar'){
            steps {
                script{
                    buildJar()
                }
            }
        }
        stage('build image'){
            steps {
                script {
                    buildImage 'otobongedoho18361/demo-app:jma-3.0'
                }
            }
        }
    
        stage('deploy'){
            steps {
                script{
                    gv.deployApp()
                }
            }
        }
    }
}

// def gv

// pipeline {
//     agent any
//     parameters {
//         choice(name: 'VERSION', choices: ['1.1.0', '1.2.0', '1.3.0'], description: '')
//         booleanParam(name: 'executeTests', defaultValue: true, description: '')
//     }
//     stages {
//         stage('init ') {
//             steps{
//                 script{
//                     gv = load "script.groovy"
//                 }
//             }

//         }
//         stage('Build') {
//             steps {
//                 script{
//                     gv.buildApp()
//                 }
                
//                 }
               
//                 // Your build commands here
//             }
        

//         stage('Test') {
//             steps {
//                script{
//                 gv.testApp()
//                }
//                 // Your test commands here
//             }
//         }


//         stage('Deploy') {
//             // input{
//             //     message "select the environment to deploy to"
//             //     ok "Done"
//             //     parameters {
//             //         choice(name: 'ONE', choices:['dev', 'staging', 'prod'], description: 'Environment')
//             //           choice(name: 'TWO', choices:['dev', 'staging', 'prod'], description: 'Environment')
//             //     }    

//             // }
//             steps {
//                script{
//                env.ENV = input message: "Select the environment to deploy to" , ok "Done" , parameters: [choice(name: 'ONE', choices:['dev', 'staging', 'prod'],
//                  description: 'Environment')]
//                 gv.deployApp()
//                 echo "Deploying to ${ENV}"
//                }     
//             }
//         }
//     }
// }
