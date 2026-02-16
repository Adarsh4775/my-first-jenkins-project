pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Code checked out from GitHub'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Run') {
            steps {
                sh 'java -cp target/classes com.example.Hello'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
