Plot p;

int cnt = 0;
void setup() {
  size(800, 500);

  String path = "C:\\Users\\ithacker\\Desktop\\InterruptThresChanges\\Data1-15 Spartan_007 (Optics Lab)\\raw\\0.csv";
  FileReader file = new FileReader(path);

  ArrayList<ArrayList<DataPoint>> data = file.ReadCSV();
  if (data == null) {
    println("File doesn't exist");
  }


  println("done");

  p = new Plot();
  ArrayList<DataPoint> arr = new ArrayList<DataPoint>();
  float angle = 0.0;
  float step = PI/24.0;
  for (int i = 0; i < 200; ++i) {
    if (i%1000000 == 0) {
      println(i);
    }
    arr.add(new DataPoint(sin(angle)));
    angle += step;
  }
  println("set data");
  p.SetData(arr);
  println("after set data");
  //p.SetYAxis(-0.5, 0.5);
}

void draw() {
  background(0);
  p.display();
  //println("start ", cnt);
  p.checkMouseIntersection();
  //println("done ", cnt);
  //noLoop();
  ++cnt;
}


//void mouseMoved() {
//  p.checkMouseIntersection();
//}
