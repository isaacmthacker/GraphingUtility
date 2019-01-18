class DataPoint {
  boolean hasValue;
  float val;
  float graph_x, graph_y;
  DataPoint(float x) {
    val = x;
    hasValue = true;
  }
  DataPoint() {
    hasValue = false;
  }
  void display(PGraphics pg) {
    pg.fill(color(255, 0, 0));
    pg.ellipse(graph_x, graph_y, 3, 3);
  }
  void display() {
    fill(color(255, 0, 0));
    ellipse(graph_x, graph_y, 3, 3);
  }
  void displayWithLabel() {
    display();
    text(val, graph_x, graph_y-30);
  }
  boolean hasData() {
    return hasValue;
  }
}
