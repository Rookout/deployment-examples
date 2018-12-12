pipelineJob("/regression-test/$jobName") {
    properties {
        disableConcurrentBuilds()
    }
    parameters {
        stringParam('NEW_VERSION', "", 'The NEW version, 8.8.8-branchname')
        stringParam('rookNodeVersion', "","the nodejs version")
        stringParam('rookCommit', "", "the commit of the nodejs application")
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