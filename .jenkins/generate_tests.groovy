println("INSIDE")
println(jobName)
pipelineJob("/regression-test/$jobName") {
    properties {
        disableConcurrentBuilds()
    }
    definition {
        cps {
            script(readFileFromWorkspace("$realpwd/$jobName/Jenkinsfile"))
            sandbox()
        }
    }
}