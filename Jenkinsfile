pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Code is already on GitHub!'
            }
        }
        stage('Compile') {
            steps {
                sh 'javac Hello.java'
                sh 'javac HelloTest.java'
            }
        }
        stage('Test') {
            steps {
                sh 'java HelloTest'
            }
        }
        stage('Run') {
            steps {
                sh 'java Hello'
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
