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

        stage('Quality Gate') {
    steps {
        timeout(time: 1, unit: 'HOURS') {
            waitForQualityGate abortPipeline: true
        }
    }
}
       
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage('Debug - Check Files') {
            steps {
                sh 'echo "===== CHECKING COMPILED CLASSES ====="'
                sh 'ls -la target/classes/com/example/ || echo "No classes found in target/classes/com/example/"'
                sh 'echo "===== CHECKING JAR FILE ====="'
                sh 'ls -la target/*.jar || echo "No JAR files found in target/"'
                sh 'echo "===== CHECKING FULL TARGET FOLDER ====="'
                sh 'ls -la target/ || echo "Target folder not found"'
            }
        }
        
        stage('Run') {
            steps {
                sh 'echo "===== ATTEMPTING TO RUN APPLICATION ====="'
                sh 'java -cp target/classes com.example.Hello || echo "Failed to run with classes folder"'
                sh 'java -cp target/my-first-app-1.0-SNAPSHOT.jar com.example.Hello || echo "Failed to run with JAR"'
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
