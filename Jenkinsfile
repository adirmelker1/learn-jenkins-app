pipeline {
    agent any

    triggers {
        // מאפשר לג'נקינס להירשם לטריגר של ה-GitHub Webhook
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                // הגדרת משיכת הקוד - ספציפית מענף main בצורה פשוטה ונקייה
                git branch: 'main', url: 'https://github.com/adirmelker1/learn-jenkins-app.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building and deploying from main branch...'
            }
        }
    }
}