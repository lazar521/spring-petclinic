pipeline {
    agent any

    parameters{
        string(name:"CREDENTIALS_ID",description:"Nexus credentials ID")
        string(name:"NEXUS_HOST",description:"Nexus host and port")
        string(name:"PROTOCOL",description:"http or https")
    }
    
    tools {
        maven 'maven-3.9.8' // Ensure this matches the name configured in Global Tool Configuration
    }

    stages {
        stage("Running Checkstyle") {
            steps {
                withMaven(maven: 'maven-3.9.8') {  // Correct usage with a map for configuration
                    sh './mvnw checkstyle:checkstyle -Dcheckstyle.output.file=target/checkstyle-result.xml'
                }
            }
        }
        
        stage("Testing"){
            steps{
                withMaven(maven:'maven-3.9.8') {
                    sh './mvnw clean test'   
                }
            }
        }
        
        stage("Build"){
            steps{
                withMaven(maven:'maven-3.9.8') {
                    sh './mvnw clean package -DskipTests'   
                }
            }
        }
    
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("spring-petclinic:latest")
                }
            }
        }
    
        stage("Push to Nexus") {
                steps {
                    script {
                        docker.withRegistry("${PROTOCOL}://${NEXUS_HOST}", "${CREDENTIALS_ID}") {
                            docker.image('spring-petclinic:latest').push('latest')
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/checkstyle-result.xml'
        }
    }
}
