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

        // stage('SonarQube analysis') {
        // environment {
        //     SCANNER_HOME = tool 'valaxy-sonar-scanner'
        // }
        //     steps{
        //         withSonarQubeEnv('valaxy-sonarqube-server') {
        //             sh "${SCANNER_HOME}}/bin/sonar-scanner"
        //            }
        //     }
        // }
    }
}