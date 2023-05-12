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
  
    stage('Terraform init'){
		steps{
			sh 'terraform init'
			}
		}

		stage('Terraform fmt'){
		steps{
			sh 'terraform fmt'
			}
		}

		stage('Terraform validate'){
		steps{
			sh 'terraform validate'
			}
		}
		

		stage('Terraform apply'){
		steps{
			sh 'terraform apply -auto-approve'
			sleep 10
			}
		}
    //stage('Deploy using Ansible') {
      //   steps {
        //    ansiblePlaybook credentialsId: 'prod-server', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'deploy-playbook.yml'
      

	}
	}
