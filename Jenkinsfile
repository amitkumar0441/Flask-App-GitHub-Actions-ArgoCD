pipeline {
    agent any 
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"  // Define IMAGE_TAG to be used in the pipeline
    }
    stages {
        stage('stage01-clonethecode') {
            steps {
                git 'https://github.com/amitkumar0441/Flask-App-GitHub-Actions-ArgoCD.git'
            }
        }
        stage('stage02-create the docker image') {
            steps {
                sh 'docker build -t amitkumar0441/flask-githubactions-argocd:${BUILD_NUMBER} .'
            }
        }
        stage('stage03-push the docker image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        docker login -u "$DOCKER_USER" -p "$DOCKER_PASS"
                        docker push amitkumar0441/flask-githubactions-argocd:${BUILD_NUMBER}
                        docker logout
                    '''
                }
            }
        }
        stage('stage04-create the deployment01.yaml') {
            steps {
                sh """
                    # Ensure IMAGE_TAG is correctly substituted with BUILD_NUMBER
                    sed -i 's|\\\$\\{IMAGE_TAG\\}|${imageTag}|g' deployment01.yaml
                """
            }
        }
        stage('stage05-Run the Kubernetes deployment') {
            steps {
                sh 'kubectl apply -f deployment01.yaml'
            }
        }
    }
}
