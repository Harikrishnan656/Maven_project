pipeline {

    agent {
        label 'worker'
    }

    environment {

        TOMCAT_IP = '172.31.0.83'
        TOMCAT_PATH = '/var/lib/tomcat10/webapps/'

        IMAGE_NAME = 'maven-webapp'
        CONTAINER_NAME = 'welcome-webapp'
    }

    stages {

        stage('Checkout') {

            steps {

                git branch: 'main',
                url: 'https://github.com/Harikrishnan656/Maven_project.git'
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
                sshagent(credentials: ['worker']) {
                    sh 'scp /var/lib/jenkins/jobs/Maven-01/builds/**.war worker@172.31.0.71:/var/lib/tomcat10/webapp/*.war
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
            mail to: 'harikrishnan.cse7@gmail.com',
                 subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Build succeeded: ${env.BUILD_URL}"
        }

        failure {
            mail to: 'harikrishnan.cse7@gmail.com',
                 subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                 body: "Build failed: ${env.BUILD_URL}"
        }
    }
}
