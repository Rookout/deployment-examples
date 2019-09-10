/* SimpleApp.scala */
import org.apache.spark.sql.SparkSession

object SimpleApp {
  def main(args: Array[String]) {
    val logFile = "test.md" // Should be some file on your system
    val spark = SparkSession.builder.appName("Simple Application").getOrCreate()
    val logData = spark.read.textFile(logFile).cache()
    val numAs = logData.filter(line => line.contains("a")).count()
    Thread.sleep(3000)
    val numBs = logData.filter(line => line.contains("b")).count()
    Thread.sleep(3000)
    println(s"Lines with a: $numAs, Lines with b: $numBs") 
    spark.stop()
  }
}
