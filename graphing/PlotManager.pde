class PlotManager extends PlotObject {
  boolean windowChanged = true;
  ArrayList<Plot> plots;
  color[] colors;
  PlotManager(ArrayList<ArrayList<DataPoint>> d) {
    plots = new ArrayList<Plot>();
    pg = createGraphics(width, height);
    maxy = Integer.MIN_VALUE;
    miny = Integer.MAX_VALUE;
    for (ArrayList<DataPoint> dd : d) {
      Plot p = new Plot();
      p.SetData(dd);
      maxy = max(maxy, p.maxy);
      miny = min(miny, p.miny);
      plots.add(p);
    }
    colors = new color[3];
    colors[0] = color(0, 0, 255);
    colors[1] = color(255, 0, 0);
    colors[2] = color(0, 255, 0);
    //colors = new color[d.size()];
    //for (int i = 0; i < d.size(); ++i) {
    //  colors[i] = color(random(0, 255), random(0, 255), random(0, 255));
    //}

    //Set Y-axis for all plots
    SetYAxis(miny, maxy);
  }
  void SetYAxis(float newminy, float newmaxy) {
    for (Plot p : plots) {
      p.SetYAxis(newminy, newmaxy);
    }
  }
  void SetXAxis(float newminx, float newmaxx) {
    for (Plot p : plots) {
      p.SetXAxis(newminx, newmaxx);
    }
  }
  void drawGridLines() {
    pg.stroke(255);
    pg.rectMode(CORNERS);
    pg.noFill();
    pg.rect(lcx, lcy, rcx, rcy);
    pg.fill(255);
    pg.rectMode(CORNER);
    pg.stroke(0);
  }
  void display() {
    if (windowChanged) {
      pg.beginDraw();
      pg.clear();
      pg.background(0);
      drawGridLines();
      println("num plots: ", plots.size());
      for (int i = 0; i < plots.size(); ++i) {
        pg.fill(colors[i]);
        pg.stroke(colors[i]);
        plots.get(i).pg = pg;
        plots.get(i).display();
      }
      pg.endDraw();
      windowChanged = false;
    }
    image(pg, 0, 0);
  }
  void checkMouseIntersection() {
    for (Plot p : plots) {
      p.checkMouseIntersection();
    }
  }
}
