pipeline {
  agent any

  tools {
      maven 'M2_HOME'
     }
  stages {
    stage('Checkout') {
       steps {
         echo 'checkout code from github repo'
	 git 'https://github.com/Pavansai283/star-agile-health-care.git'
	 }
	}
  stage('building application') {
       steps {
         echo "Cleaning... Compiling... Testing... Packaging..."
         sh 'mvn clean package'
      }
      }
   stage('Publish Reports') {
       steps {
       publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Healthcare/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
       }
	}
   stage('Docker image creating') {
       steps {
       sh 'docker build -t pavanputtur/healthcare:1.0 .'
       }
       }
   stage('pushing to dockerhub') {
       steps {
       withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
       sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
       sh 'docker push pavanputtur/healthcare:1.0'
       }
       }
       }
    stage('Deploy using Ansible') {
       steps {
       ansiblePlaybook credentialsId: 'prod-server', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts', playbook: 'deploy-playbook.yml'
       }
}
   stage('Deploying to Kubernetes') {
       steps {
        script {
          kubernetesDeploy (configs: 'deployment.yml', kubeconfigId: 'kubernetes')
	}
	}
	}
	}
	}
