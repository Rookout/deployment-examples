pipelineJob("/regression-test/$jobName") {
    properties {
        disableConcurrentBuilds()
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