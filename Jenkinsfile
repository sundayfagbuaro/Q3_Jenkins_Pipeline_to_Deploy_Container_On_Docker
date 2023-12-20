pipeline {
    agent any
    
    stages {
        stage('SCM Checkout') {
            steps {
                // cloning repo
                git credentialsId: 'git', url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the image"
                sh 'docker build -t sundayfagbuaro/jenkdockapp:v3.0 .'
            }
        }

        stage ("Push Docker Image") {
            steps {
                    echo "Pushing the built image to docker hub"
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerHubPwd')]) {
                sh 'docker login -u sundayfagbuaro -p ${DockerHubPwd}' 
                }
                sh 'docker push sundayfagbuaro/jenkdockapp:v3.0'
            }
        }

        stage('Run Container on The Dev Server') {
            steps {
                script {
                    sshagent(['dev_server']) {
                        sh """ssh -tt -o StrictHostKeyChecking=no bobosunne@192.168.1.85 << EOF
                        docker run -d -p 8082:80 --name dockerapp_new sundayfagbuaro/testapp:v1.0
                        exit
                        EOF"""
                    }
                }
            }
        }
    }
}