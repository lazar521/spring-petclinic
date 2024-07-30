pipeline {
    agent any

    stages {
        stage("Running Checkstyle") {
            steps {
                withMaven() {
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