pipelineJob("/regression-test/$jobName") {
    properties {
        disableConcurrentBuilds()
    }
    parameters {
        stringParam('NEW_VERSION')
    }
    environmentVariables(
            testDir: "$jobName"
    )
    definition {
        cps {
            script(readFileFromWorkspace("$realpwd/$jobName/Jenkinsfile"))
            sandbox()
        }
    }
}