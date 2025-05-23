pipeline {
  agent any
  stages {

    stage('run ansible playbook') {
      steps {
        sh '''
          ansible-playbook playbook.yaml -i inventory.ini
        '''
      }
    }
    
  }
  environment{
     PATH = "/usr/local/bin:$PATH"
     email = "cissemadicke8@gmail.com"
  }
}

