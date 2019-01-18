class FileReader {
  String path;
  BufferedReader reader;
  FileReader(String p) {
    path = p;
    reader = createReader(path);
  }
  boolean validFile() {
    return reader!=null;
  }
  ArrayList<ArrayList<DataPoint>> ReadCSV() {
    if (!validFile()) {
      return null;
    }
    ArrayList<ArrayList<DataPoint>> data = new ArrayList<ArrayList<DataPoint>>();
    boolean valid = true;
    String line = null;
    int cnt = 0;
    while (valid) {
      try {
        line = reader.readLine();
      } 
      catch(IOException e) {
        valid = false;
        line = null;
        println("hit end");
        break;
      }
      if (line != null) {
        String[] arr = line.split(",");
        if (cnt == 0) {
          for (int i = 0; i < arr.length; ++i) {
            data.add(new ArrayList<DataPoint>());
          }
        } else { 
          for (int i = 0; i < arr.length; ++i) {
            try {
              data.get(i).add(new DataPoint(Float.parseFloat(arr[i])));
            }      
            catch(NumberFormatException e) {
              data.get(i).add(new DataPoint());
            }
          }
        }
        ++cnt;
      } else {
        valid = false;
      }
    }
    return data;
  }
}
