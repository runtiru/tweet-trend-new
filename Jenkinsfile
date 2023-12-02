pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
}
    stages {
        stage('build') {
            steps {
                sh 'mvn clean deploy'
            }
        }
        stage("test") {
            steps {
                sh 'mvn surefire-report:report'
            }
        }
        stage ("Sonar Analysis") {
            environment {
               scannerHome = tool 'valaxy-sonar-scanner'
            }
            steps {
                echo 'Sonar Analysis started'
                withSonarQubeEnv('valaxy-sonarqube-server') {    
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}