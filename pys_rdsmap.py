import au.com.bytecode.opencsv.CSVParser
import org.apache.spark.rdd.RDD
import org.apache.spark.SparkContext._

def dropHeader(data: RDD[String]): RDD[String] = {
  data.mapPartitionsWithIndex((idx, lines) => {
    if (idx == 0) {
      lines.drop(1)
    }
    lines
  })
}

// https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2

val crimeFile = "/Users/markneedham/Downloads/Crimes_-_2001_to_present.csv"
val crimeData = sc.textFile(crimeFile).cache()

val withoutHeader: RDD[String] = dropHeader(crimeData)

val file = "/tmp/primaryTypes.csv"
FileUtil.fullyDelete(new File(file))

val partitions: RDD[(String, Int)] = withoutHeader.mapPartitions(lines => {

  val parser = new CSVParser(',')

  lines.map(line => {

    val columns = parser.parseLine(line)

    (columns(5), 1)

  })

})

val counts = partitions.

  reduceByKey {case (x,y) => x + y}.

  sortBy {case (key, value) => -value}.

  map { case (key, value) => Array(key, value).mkString(",") }

counts.saveAsTextFile(file)
