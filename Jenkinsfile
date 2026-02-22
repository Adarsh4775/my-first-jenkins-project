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
        
        stage('Security Scan') {
            steps {
                sh 'trivy fs --severity HIGH,CRITICAL --no-progress .'
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage('Upload to Artifactory') {
            steps {
                rtUpload(
                    serverId: 'artifactory',
                    spec: '''{
                        "files": [{
                            "pattern": "target/*.jar",
                            "target": "libs-snapshot-local/"
                        }]
                    }'''
                )
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t adarsh7890/my-first-app:latest .'
            }
        }
        
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push adarsh7890/my-first-app:latest
                    '''
                }
            }
        }
        
        stage('Debug - Check Files') {
            steps {
                sh 'ls -la target/*.jar || echo "No JAR found!"'
            }
        }
        
        stage('Run') {
            steps {
                sh 'java -cp target/my-first-app-1.0-SNAPSHOT.jar com.example.Hello || echo "Failed to run with JAR"'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline executed successfully!'
            emailext(
                to: 'adarshpujari22100@gmail.com',
                subject: "✅ SUCCESS: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                body: """
                    <h2>Pipeline Executed Successfully!</h2>
                    <p><b>Job:</b> ${env.JOB_NAME}</p>
                    <p><b>Build:</b> #${env.BUILD_NUMBER}</p>
                    <p><b>URL:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p><b>Docker Image:</b> adarsh7890/my-first-app:latest</p>
                    <p><b>Artifactory:</b> libs-snapshot-local/my-first-app-1.0-SNAPSHOT.jar</p>
                """,
                mimeType: 'text/html'
            )
        }
        failure {
            echo 'Pipeline failed!'
            emailext(
                to: 'adarshpujari22100@gmail.com',
                subject: "❌ FAILED: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                body: """
                    <h2>Pipeline Failed!</h2>
                    <p><b>Job:</b> ${env.JOB_NAME}</p>
                    <p><b>Build:</b> #${env.BUILD_NUMBER}</p>
                    <p><b>URL:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    <p>Check console output for details.</p>
                """,
                mimeType: 'text/html'
            )
        }
    }
}
