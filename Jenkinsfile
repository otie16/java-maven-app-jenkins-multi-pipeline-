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
                    echo 'Deploying the application'
                    echo "Executing pipeline for branch BRANCH_NAME"
                }
            }
        }
    }
}