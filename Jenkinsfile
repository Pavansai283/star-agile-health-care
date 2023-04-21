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
    //stage('Deploy using Ansible') {
      // steps {
       //ansiblePlaybook credentialsId: 'prod-server', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'deploy-playbook.yml'
       //}
	//}
    stage('Deploy to k8s') {
        steps {
            sshagent(['prod-server']) {
            sh 'sudo scp -r -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/healthcare/deploymentservice.yml ubuntu@172.31.40.60:/home/ubuntu'
            script {
                try {
                    sh "ssh ubuntu@172.31.40.60 kubectl apply -f deploymentservice.yml"
               }catch(error) {
                   sh "ssh ubuntu@172.31.40.60 kubectl create -f deploymentservice.yml" 
	 }
	}
	}
	}
	}
	}
	}

