pipeline {
    agent any

    triggers {
        // מאפשר לג'נקינס להתעורר משינויים ופתיחת PR-ים ב-GitHub
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                // שימוש ב-checkout scm מאפשר לג'נקינס למשוך אוטומטית
                // את הענף הספציפי שהפעיל את הטריגר (כולל ענפי פיצ'ר ב-PR)
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building and testing...'
                // כאן תריץ את הבדיקות שלך, למשל:
                // sh 'npm install && npm test'
            }
        }
    }

    post {
    success {
        // במקום githubNotify
        setGitHubPullRequestStatus(state: 'SUCCESS', message: 'The build passed!')
    }
    failure {
        setGitHubPullRequestStatus(state: 'FAILURE', message: 'The build failed!')
    }
}
}