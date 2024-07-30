pipeline {
    agent any

    stages {
        stage("Running Checkstyle") {
            steps {
                withMaven("maven-3.9.8") {
                    sh './mvnw checkstyle:checkstyle'
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: './target/checkstyle-result.xml'
        }
    }
}