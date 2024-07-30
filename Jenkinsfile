pipeline {
    agent any

    parameters {
        string(name:"IMAGE_NAME",description:"Name of the image to be created (lowercase)"
        string(name: "CREDENTIALS_ID", description: "Nexus credentials ID")
        string(name: "HISTORY_REPO_URL", description: "Nexus history repo URL (with protocol)")
        string(name: "MAIN_REPO_URL", description: "Nexus main repo URL (with protocol)")
    }
    
    tools {
        maven 'maven-3.9.8' // Ensure this matches the name configured in Global Tool Configuration
    }


    stages {
        // stage("Running Checkstyle") {
        //     steps {
        //         withMaven(maven: 'maven-3.9.8') {
        //             sh './mvnw checkstyle:checkstyle -Dcheckstyle.output.file=target/checkstyle-result.xml'
        //         }
        //     }
        // }
        
        // stage("Testing") {
        //     steps {
        //         withMaven(maven: 'maven-3.9.8') {
        //             sh './mvnw clean test'
        //         }
        //     }
        // }
        
        stage("Build") {
            steps {
                withMaven(maven: 'maven-3.9.8') {
                    sh './mvnw clean package -DskipTests'
                }
            }
        }
    
        stage("Build Docker Image") {
            steps {
                script {
                    docker.build("${params.IMAGE_NAME}:${env.GIT_COMMIT}")
                }
            }
        }
    
        stage("Push to history repository") {
            steps {
                script {
                    docker.withRegistry("${params.HISTORY_REPO_URL}", "${params.CREDENTIALS_ID}") {
                        docker.image("${params.IMAGE_NAME}:${env.GIT_COMMIT}").push("${env.GIT_COMMIT}")
                    }
                }
            }
        }

        stage("Push to main repository") {
            when{
                expression{
                    BRANCH_NAME == 'main'
                }
            }
            steps {
                script {
                    docker.withRegistry("${params.MAIN_REPO_URL}", "${params.CREDENTIALS_ID}") {
                        docker.image("${params.IMAGE_NAME}:${env.GIT_COMMIT}").push("${env.GIT_COMMIT}")
                    }
                }
            }
        }

        
    }

    // post {
    //     always {
    //         archiveArtifacts artifacts: 'target/checkstyle-result.xml'
    //     }
    // }
}
