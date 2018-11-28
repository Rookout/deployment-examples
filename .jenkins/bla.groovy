import groovy.io.FileType

def list = []

def dir = new File("..")
dir.eachFileRecurse (FileType.FILES) { file ->
  if ("Jenkinsfile".equals(file.name)){
  def dirName = file.getParentFile().getName()
  if (!(".jenkins".equals(dirName))){
      println(dirName)
  list << dirName
    }
  }
}
