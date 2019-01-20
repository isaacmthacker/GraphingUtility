class DataPoint {
  //Indicates if the data points has a value associated with it
  //A form of the None type
  boolean hasValue;
  //data point
  float val;
  //graphical x and y locations
  float graph_x, graph_y;
  //size of ellipse
  float pointSize = 5.0;
  //Constructor with data
  DataPoint(float x) {
    val = x;
    hasValue = true;
  }
  //None constructor
  DataPoint() {
    hasValue = false;
  }
  //Draws point to PGraphics object
  void display(PGraphics pg) {
    pg.ellipse(graph_x, graph_y, pointSize, pointSize);
  }
  //Draws point to screen
  void display() {
    ellipse(graph_x, graph_y, pointSize, pointSize);
  }
  //Draws point to screen with label
  void displayWithLabel() {
    display();
    text(val, graph_x, graph_y-30);
  }
  boolean hasData() {
    return hasValue;
  }
  boolean intersectMouse() {
    return (graph_x-mouseX)*(graph_x-mouseX) + (graph_y-mouseY)*(graph_y-mouseY) <= pointSize*pointSize;
  }
}
