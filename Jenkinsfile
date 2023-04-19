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
	}
	}
