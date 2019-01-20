PlotManager p;

int cnt = 0;
boolean clicked = false;
float recx, recy;
void setup() {
  size(800, 500);

  String path = "//Users//ithacker//Desktop//points.csv";
  FileReader file = new FileReader(path);

  ArrayList<ArrayList<DataPoint>> data = file.ReadCSV();
  if (data == null) {
    println("File doesn't exist");
  } else {
    p = new PlotManager(data);
    p.SetYAxis(-1, 1);
  }


  println("done");

  //ArrayList<DataPoint> sin = new ArrayList<DataPoint>();
  //ArrayList<DataPoint> cos = new ArrayList<DataPoint>();
  //ArrayList<DataPoint> tan = new ArrayList<DataPoint>();
  //float angle = 0.0;
  //float step = PI/24.0;
  //for (int i = 0; i < 100; ++i) {
  //  println(sin(angle), cos(angle));
  //  sin.add(new DataPoint(sin(angle)));
  //  cos.add(new DataPoint(cos(angle)));
  //  tan.add(new DataPoint(tan(angle)));
  //  angle += step;
  //}
  //println("set data");
  //println("after set data");
  //ArrayList<ArrayList<DataPoint>> trig = new ArrayList<ArrayList<DataPoint>>();
  //trig.add(sin);
  //trig.add(cos);
  //trig.add(tan);
  //p = new PlotManager(trig);
  //p.SetYAxis(-1, 1);
}




void draw() {
  background(0);
  p.display();
  //println("start ", cnt);
  p.checkMouseIntersection();
  //println("done ", cnt);
  //noLoop();
  ++cnt;
  if (clicked) {
    noFill();
    stroke(255);
    rect(recx, recy, mouseX-recx, mouseY-recy);
  }
}

void mousePressed() {
  if (clicked) {
    clicked = false;
  } else {
    clicked = true;
    recx = mouseX;
    recy = mouseY;
  }
}

void mouseReleased() {
  clicked = false;
}
