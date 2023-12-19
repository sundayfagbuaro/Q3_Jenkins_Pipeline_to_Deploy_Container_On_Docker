#def AGENT_LABEL = null

#node('master') {
#  stage('Checkout and set agent'){
#     checkout scm
#     ### Or just use any other approach to figure out agent label: read file, etc
#    if (env.BRANCH_NAME == 'main') {
#        AGENT_LABEL = "prod"
#     } else {
#        AGENT_LABEL = "JENKINS-AGENT-1"
#     }
#   }
#}

def AGENT_LABEL = null

node('master') {
  stage('Git Checkout and set agent'){
    git credentialsId: 'git', url: 'https://github.com/sundayfagbuaro/Q3_Jenkins_Pipeline_to_Deploy_Container_On_Docker.git'
     
    
    if (env.BRANCH_NAME == 'main') {
        AGENT_LABEL = "JENKINS-AGENT-1"
     } else {
        AGENT_LABEL = "JENKINS-AGENT-2"
     }
   }
}
    

pipeline {
    agent {
       label "${AGENT_LABEL}"
    }

    stages {
        stage('Build Docker Image') {
           steps {
              echo "Running in ${AGENT_LABEL}"
              sh 'docker build -t sundayfagbuaro/testapp:v2.0 .'
           }
        } 

        stage ("Push Docker Docker Image") {
            steps {
                    echo "Running on ${AGENT_LABEL}"
                    withCredentials([string(credentialsId: 'docker-pwd', variable: 'DockerHubPwd')]) {
                sh 'docker login -u sundayfagbuaro -p ${DockerHubPwd}' 
                }
                sh 'docker push sundayfagbuaro/testapp:v2.0'
            }
        }

        stage('Deploy Container on The Devserver'){
            steps {
                    sshagent(['dev_server']) {
                sh 'ssh -o StrictHostKeyChecking=no bobosunne@192.168.1.85'
                sh 'docker run -d -p 8081:80 --name dockerapp_test sundayfagbuaro/testapp:v2.0'
                }
            }
        
        }

    }
}

