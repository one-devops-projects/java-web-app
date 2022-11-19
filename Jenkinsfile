pipeline{
    agent{
        label 'docker'
    }
    
    tools {
        maven 'maven-3.8.6'
    }
    
    stages{
        stage('Pull code from SCM'){
            steps{
                git 'https://github.com/MithunTechnologiesDevOps/maven-web-application.git'
            }
        }
        stage('Build Code'){
            steps{
                sh "mvn clean package"
            }
        }
        stage('Create Web App Image'){
            steps{
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 537960581474.dkr.ecr.us-east-1.amazonaws.com"
                
                sh "docker build -t 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER} ."
            }
        }
        stage('Push Web App Image to AWS ECR'){
            steps{
                sh "docker push 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER}"
            }
        }
        stage('Pull and run image from AWS ECR'){
            steps{
                sshagent(['ea8709c0-f221-4d17-892f-a70989dd7e0b']) {
                // some block
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.86.179 && aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 537960581474.dkr.ecr.us-east-1.amazonaws.com"
                    //sh "docker pull 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER}"
                    sh "docker run -d --maven-web-app -p 8080:8080 537960581474.dkr.ecr.us-east-1.amazonaws.com/java-web-app:${BUILD_NUMBER}"
                }
            }
        }
        
    }//End of stages
    
}