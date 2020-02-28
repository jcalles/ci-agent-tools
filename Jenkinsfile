#!groovy

pipeline {
  agent {
    kubernetes {
      label "docker-${UUID.randomUUID().toString()}"
      yamlFile 'kubernetes/AgentPod.yaml'
    }
  }
  environment {
    IMAGE_NAME = 'buildpack'
    IMAGE_TAG = 'v1.0'
    GC_REGISTRY_HOSTNAME = 'gcr.io'
    GC_PROJECT_ID = 'THE_PROJECT_ID'
  }
  stages {
    stage('Build & Push Image') {
      steps {
        container('docker') {
          script {
            imageRepository = "${env.GC_REGISTRY_HOSTNAME}/${env.GC_PROJECT_ID}/${env.IMAGE_NAME}"
            image = docker.build("${imageRepository}:${env.IMAGE_TAG}", ".")
            image.push()
          }
        }
      }
      post {
        always {
          container('docker') {
            sh "docker rmi -f ${image.id}"
          }
        }
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
