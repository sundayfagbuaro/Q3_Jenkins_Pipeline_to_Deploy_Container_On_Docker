pipeline {
    agent any
    
    stages {
        stage('SCM Checkout') {
            steps {
                script {
                    git branch: 'dev_test',
                        credentialsId: 'git-hub', 
                        url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
                // cloning repo
                // git credentialsId: 'git', url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the image"
                sh 'docker build -t sundayfagbuaro/docker-test:2.0 .'
            }
        }

	stage ('Push Image To Docker Hub'){
	    steps{
		echo "Pushing the built image to docker hub"
		withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'docker_pass', usernameVariable: 'docker_user')]) {
            sh 'docker login -u sundayfagbuaro -p ${docker_pass}' 
	    }
	    sh 'docker push sundayfagbuaro/docker-test:2.0'
         }
	}

        stage('Run Container on Docker Host') {
            steps {
                script {
                    sshagent(['bobosunne-test-svr']) {
        		sh """ssh -tt -o StrictHostKeyChecking=no bobosunne@192.168.1.158 << EOF
            		docker run -d -p 8082:80 --name docker-test2-new sundayfagbuaro/docker-test:2.0
            		exit
            		EOF"""
        		}
		}
            }
        }
    }
}
