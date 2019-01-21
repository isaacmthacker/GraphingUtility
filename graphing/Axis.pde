class Axis extends PlotObject {
  //Used for drawing line for x and y axies
  float xstep, ystep;
  //Used for determing xstep and ystep;
  float numXPoints = 10.0;
  float numYPoints = 10.0;
  //Used to draw grid ticks
  float xlinesize, ylinesize;

  int dataSize;
  Axis(int sizeOfData) {
    dataSize = sizeOfData;
    xstep = w/numXPoints;
    ystep = h/numYPoints;
    xlinesize = w*0.01;
    ylinesize = h*0.01;
  }
  void SetXAxis(float newminx, float newmaxx) {
    minx = newminx;
    maxx = newmaxx;
  }
  void SetYAxis(float newminy, float newmaxy) {
    miny = newminy;
    maxy = newmaxy;
  }
  void SetXPoints(float numPoints) {
    numXPoints = numPoints;
  }
  void SetYPoints(float numPoints) {
    numYPoints = numPoints;
  }
  void drawBorder() {
    pg.stroke(255);
    pg.rectMode(CORNERS);
    pg.noFill();
    pg.rect(lcx, lcy, rcx, rcy);
    pg.fill(255);
    pg.rectMode(CORNER);
    pg.stroke(0);
  }
  void drawXGridLines() {
    float x = lcx;
    float y = lcy;
    pg.stroke(255);
    for (int i = 0; i < numXPoints; ++i) {
      pg.line(x, y-ylinesize, x, y+ylinesize);
      x += xstep;
    }
  }
  void drawYGridLines() {
    float x = lcx;
    float y = lcy;
    pg.stroke(255);
    for (int i = 0; i < numYPoints; ++i) {
      println(x, y);
      pg.line(x-xlinesize, y, x+xlinesize, y);
      y -= ystep;
    }
  }
  void drawGridLines() {
    drawXGridLines();
    drawYGridLines();
  }

  void display() {
    drawBorder();
    drawGridLines();
  }
}
