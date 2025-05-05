#!/usr/bin/env groovy 

/*
 * This file bootstraps the codified Continuous Delivery pipeline for extensions of SAP solutions such as SAP S/4HANA.
 * The pipeline helps you to deliver software changes quickly and in a reliable manner.
 * A suitable Jenkins instance is required to run the pipeline.
 * More information on getting started with Continuous Delivery can be found here: https://www.project-piper.io/
 */

// @Library('piper-lib-os') _

// piperPipeline script: this

pipeline {
    agent any

    environment {
        MTA_PATH = "${WORKSPACE}"
        MTAR_NAME = "DemoCAPMApp.mtar"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                dir("${MTA_PATH}") {
                    sh 'npm install'
                }
            }
        }

        stage('Build CAP Artifacts') {
            steps {
                dir("${MTA_PATH}") {
                    sh 'npx cds build'
                }
            }
        }

        stage('Deploy CAP Artifacts') {
            steps {
                dir("${MTA_PATH}") {
                    sh 'npx cds deploy'
                }
            }
        }

        stage('Build MTA Project') {
            steps {
                dir("${MTA_PATH}") {
                    sh 'mbt build'
                }
            }
        }

        stage('Package MTAR') {
            steps {
                dir("${MTA_PATH}") {
                    sh 'make -f Makefile.mta p=CF mtar=${MTAR_NAME} strict=true mode= t="${MTA_PATH}"'
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: "mta_archives/${MTAR_NAME}", fingerprint: true
            }
        }
    }

    post {
        failure {
            echo 'Build failed. Please check the logs above.'
        }
    }
}
