pipeline{
    agent any
    stages{
        stage('test'){
            steps{
                script{
                    echo 'testing the application...'
                    echo "Executing pipeline for branch BRANCH_NAME"
                }
            }
        }
        stage('build'){
            when {
                expression{
                    BRANCH_NAME == "master"
                }
            }
            steps{
                script{
                    echo 'building the application'
                    echo 'new added to jenkinsjobs'
                }
            }
        }
        stage('deploy'){
            steps{
                script{
                    def dockerCommand = 'docker run -p 3080:3080 -d otobongedoho18361/demo-app:jma-3.0'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@34.239.133.89 ${dockerCommand}"
                    }
                    // echo 'Deploying the application'
                    // echo "Executing pipeline for branch BRANCH_NAME"
                }
            }
        }
    }
}
