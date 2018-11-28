import groovy.io.FileType
import org.rookout.files.Utilities
Utilities.checkIfFileExist(this, 'helm', 'Makefile')
def list = []
println("OKOK")
def dir = new File("..")
dir.traverse(type: FileType.DIRECTORIES, maxDepth: 0){ file ->
  if (file.isDirectory()) {
  println(file)
  list << file
  }
}