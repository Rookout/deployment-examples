import groovy.io.FileType
def list = []
println("OKOK")
println("$message")
def dir = new File("..")
dir.traverse(type: FileType.DIRECTORIES, maxDepth: 0){ file ->
  if (file.isDirectory()) {
  println(file)
  list << file
  }
}
script(readFileFromWorkspace('.jenkins/sentry-cron.Jenkinsfile'))
