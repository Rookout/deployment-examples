import groovy.io.FileType

def list = []

def dir = new File("..")
dir.traverse(type: FileType.DIRECTORIES, maxDepth: 0){ file ->
  if (file.isDirectory()) {
  println(file)
  list << file
  }
}