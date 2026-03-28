pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "medu4464/swe645-hw2-survey:1.0"
        KUBECONFIG_PATH = "/etc/rancher/rke2/rke2.yaml"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/AbdulhamidAlhumaid/survey2_swe645.html.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                )]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                sudo KUBECONFIG=/etc/rancher/rke2/rke2.yaml /var/lib/rancher/rke2/bin/kubectl apply -f deployment.yaml
                sudo KUBECONFIG=/etc/rancher/rke2/rke2.yaml /var/lib/rancher/rke2/bin/kubectl rollout restart deployment swe645-survey-deployment
                '''
            }
        }
    }
}
