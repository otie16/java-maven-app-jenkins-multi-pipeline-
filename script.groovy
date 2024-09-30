def buildJar() {
    echo "building the application..."
    sh 'mvn package'
} 

def buildImage(){
    echo "building the docker image..."
    // Extracting the github credentials from jenkins 
    withCredentials([usernamePassword(credentialsId: 'dockerhub-repo-credentials', passwordVariable: 'PASS', usernameVariable: 'USER', )]){
        sh 'docker build -t otobongedoho18361/demo-app:jma-2.0 .'
        sh 'echo $PASS | docker login -u $USER --password-stdin'
        sh 'docker push otobongedoho18361/demo-app:jma-2.0'
    } 
}

def deployApp() {
    echo 'deploying the application...'
} 

return this
