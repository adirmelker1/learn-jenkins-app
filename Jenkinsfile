pipeline {
    agent any

    tools {
        nodejs 'node-20'
    }

    triggers {
        // מאפשר לג'נקינס להתעורר משינויים ופתיחת PR-ים ב-GitHub
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                // משיכה ישירה ומפורשת מה-Repository שלך
                git branch: 'main', url: 'https://github.com/adirmelker1/learn-jenkins-app.git'
            }
        }

        stage('Lint & Format') {
            steps {
                sh 'npm ci --legacy-peer-deps'
                echo 'sh npm lint'
                sh 'npm run lint'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // ג'נקינס יתקין ויביא את הנתיב של הסורק שהגדרת ב-Tools תחת השם 'SonarQube-Scanner'
                    def scannerHome = tool 'SonarQube-Scanner'

                    // הרצת הסריקה באמצעות שימוש בנתיב המלא של הסורק שהותקן
                    withSonarQubeEnv('SonarQube-Server') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=my-jenkins-app \
                            -Dsonar.sources=."
                    }
                } // סגירת script
            } // סגירת steps
        } // סגירת stage של האנליזה

        stage('SonarQube Quality Gate') {
            steps {
                // מומלץ לעטוף את ההמתנה ב-timeout כדי שה-Pipeline לא ייתקע לנצח אם יש בעיית תקשורת
                timeout(time: 10, unit: 'MINUTES') {
                    script {
                        // הפקודה שממש עוצרת וממתינה לתשובה משרת ה-SonarQube
                        def qg = waitForQualityGate()

                        // בדיקה האם התוצאה תקינה
                        if (qg.status != 'OK') {
                            error "Pipeline failed due to code quality issues: ${qg.status}"
                        }
                    } // סגירת script
                } // סגירת timeout
            } // סגירת steps
        } // סגירת stage של ה-Quality Gate

        stage('Build') {
            steps {
                echo 'Building and testing...'
                // כאן תריץ את הבדיקות שלך, למשל:
                // sh 'npm install && npm test'
            }
        }
    } // סגירת stages

    post {
        success {
            // מעדכן את סטטוס הקומיט ב-GitHub כ-Success
            step([$class: 'GitHubCommitStatusSetter',
                  reposSource: [$class: 'ManuallyEnteredRepositorySource', url: 'https://github.com/adirmelker1/learn-jenkins-app.git'],
                  contextSource: [$class: 'DefaultCommitContextSource', context: 'full-pipeline'],
                  statusResultSource: [$class: 'ConditionalStatusResultSource', results: [[$class: 'BetterThanOrEqualBuildResult', result: 'SUCCESS', state: 'SUCCESS', message: 'The build passed!']]]
            ])
        }
        failure {
            // מעדכן את סטטוס הקומיט ב-GitHub כ-Failure
            step([$class: 'GitHubCommitStatusSetter',
                  reposSource: [$class: 'ManuallyEnteredRepositorySource', url: 'https://github.com/adirmelker1/learn-jenkins-app.git'],
                  contextSource: [$class: 'DefaultCommitContextSource', context: 'full-pipeline'],
                  statusResultSource: [$class: 'ConditionalStatusResultSource', results: [[$class: 'BetterThanOrEqualBuildResult', result: 'FAILURE', state: 'FAILURE', message: 'The build failed!']]]
            ])
        }
    }
}