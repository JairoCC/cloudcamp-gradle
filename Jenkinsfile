node('docker'){
    repository = "JairoCC/cloudcamp-gradle".toLowerCase()
    stage('init'){
        sh "sudo apt install openjdk-25-jdk git -y"
    }
    stage('checkout'){
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/JairoCC/cloudcamp-gradle']])
    }
    stage('unit test'){
        sh '''chmod +x gradlew
            ./gradlew test'''
    }
    stage('build container'){
        sh "docker build -t ghcr.io/${repository}/gradle-micro:latest ."
    }
    stage('registry login'){
        withCredentials([usernamePassword(credentialsId: 'git-credentials', passwordVariable: 'PAT_TOKEN', usernameVariable: 'GIT_USERNAME')]) {
            sh "echo ${PAT_TOKEN} | docker login ghcr.io -u ${GIT_USERNAME} --password-stdin"
        }
    }
    stage('deploy container'){
        sh "docker push ghcr.io/${repository}/gradle-micro:latest"
    }
}