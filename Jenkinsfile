pipeline {
    agent any

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
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/checkstyle-result.xml'
        }
    }
}
