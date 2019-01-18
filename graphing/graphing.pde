Plot p;
float x, y;
void setup() {
  size(1500, 750);

  String path = "C:\\Users\\ithacker\\Desktop\\InterruptThresChanges\\Data1-15 Spartan_007 (Optics Lab)\\raw\\0.csv";
  BufferedReader reader = createReader(path);
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
  println("done");
  data.clear();
  p = new Plot();
  ArrayList<DataPoint> arr = new ArrayList<DataPoint>();
  float angle = 0.0;
  float step = PI/24.0;
  for (int i = 0; i < 200; ++i) {
    arr.add(new DataPoint(sin(angle)));
    angle += step;
  }
  p.SetData(arr);
  //p.SetYAxis(-0.5, 0.5);
  x = mouseX;
  y = mouseY;
}

void draw() {
  background(0);
  p.display();
  //noLoop();
}

void mouseMoved() {
  stroke(255);
  line(x, y, mouseX, mouseY);
  x = mouseX;
  y = mouseY;
}
