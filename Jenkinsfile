def registry = 'https://runner1.jfrog.io'
def imageName = 'runner1.jfrog.io/valaxy-docker-local/ttrend'
def version   = '2.1.2'
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
        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage("Jar Publish") {
            steps {
                script {
                    echo 'Jar Publish Started'
                      def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artiface-cred"
                      def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                      def uploadSpec = """{
                        "files": [
                            {
                                "pattern": "jarstaging/(*)",
                                "target": "libs-release-local/{1}",
                                "flat": "false",
                                "props" : "${properties}",
                                "exclusions": [ "*.sha1", "*.md5"]
                                }
                            ]
                        }"""
                      def buildInfo = server.upload(uploadSpec)
                      buildInfo.env.collect()
                      server.publishBuildInfo(buildInfo)
                      echo 'Jar Publish Ended'
                }
            }   
        }
        stage(" Docker Build ") {
            steps {
                script {
                    echo 'Docker Build Started'
                    app = docker.build(imageName+":"+version)
                    echo 'Docker Build Ends'
        }
      }
    }

        stage (" Docker Publish ") {
            steps {
                script {
                    echo 'Docker Publish Started'  
                    docker.withRegistry(registry, 'artiface-cred') {
                    app.push()
                    }    
                    echo 'Docker Publish Ended'  
                }
            }
        }
    }
}
