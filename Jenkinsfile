pipeline {

    agent {
        label 'slave'
    }

    environment {

        TOMCAT_PATH = '/var/lib/tomcat10/webapps/'

        IMAGE_NAME = 'maven-webapp'
        CONTAINER_NAME = 'welcome-webapp'
    }

    stages {

        stage('Checkout') {

            steps {

                git branch: 'main',
                url: 'https://github.com/harikrishnan-knr/Devops_Takeaway.git'
            }
        }

        stage('Build Maven') {

            steps {

                sh 'java -version'
                sh 'mvn -version'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Verify Artifact') {

            steps {

                sh 'ls -lh target/'
            }
        }

        stage('Build Docker Image') {

            steps {

                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Stop Old Container') {

            steps {

                sh 'docker stop ${CONTAINER_NAME} || true'
                sh 'docker rm ${CONTAINER_NAME} || true'
            }
        }

        stage('Run Docker Container') {

            steps {

                sh 'docker run -d --name ${CONTAINER_NAME} -p 8090:8080 ${IMAGE_NAME}:latest'
            }
        }

        stage('Verify Container') {

            steps {

                sh 'docker ps'
            }
        }

        stage('Deploy Tomcat') {

            steps {

                    sh "sudo cp  target/*.war {TOMCAT_PATH}war.war"
                }
            }
        
    }

post {
        success {
            mail to: 'harikrishnanknr07@gmail.com',
                 subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Build succeeded: ${env.BUILD_URL}"
        }

        failure {
            mail to: 'harikrishnanknr07@gmail.com',
                 subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Build failed: ${env.BUILD_URL}"
        }
    }
}
