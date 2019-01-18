class Plot {
  ArrayList<DataPoint> data;
  float miny, maxy;
  float minx, maxx;
  float lcx, lcy, rcx, rcy;      //TODO: rename
  float w, h;
  float p = 0.025;
  PGraphics pg;
  boolean graphChanged = true;
  Plot() {
    miny = 0.0;
    maxy = 0.0;
    minx = 0;
    maxx = 0;
    lcx = width*p;
    lcy = height*(1-p);
    rcx = width*(1-p);
    rcy = height*p;
    w = width-2*width*p;
    h = height-2*height*p;
    data = new ArrayList<DataPoint>();
    pg = createGraphics(width, height);
  }

  void SetData(ArrayList<DataPoint> d) {
    data = d;
    minx = 0;
    maxx = data.size();
    miny = Integer.MAX_VALUE;
    maxy = Integer.MIN_VALUE;
    for (int i = 0; i < data.size(); ++i) {
      if (data.get(i).hasData()) {
        miny = min(miny, data.get(i).val);
        maxy = max(maxy, data.get(i).val);
      }
    }
    println(miny, maxy);
  }
  void SetXAxis(float minxx, float maxxx) {
    minx = minxx;
    maxx = maxxx;
  }  
  void SetYAxis(float minyy, float maxyy) {
    //TODO: need a way to just change the viewing y here
    miny = minyy;
    maxy = maxyy;
  }
  void drawGridLines() {
    pg.stroke(255);
    pg.line(lcx, lcy, rcx, lcy);
    pg.line(lcx, lcy, lcx, rcy);
    pg.line(lcx, rcy, rcx, rcy);
    pg.line(rcx, rcy, rcx, lcy);
    pg.stroke(0);
  }
  float Translate(float point) {
    float scale = (rcy-lcy)/(maxy-miny);
    //println(maxy, miny, rcy, lcy, scale);
    float val = (point-miny)*scale + lcy;
    return val;
  }
  void drawData() {
    float xPos = lcx;
    float xstep = w/(data.size()-1);
    for (int i = 0; i < data.size(); ++i) {
      if (data.get(i).hasData()) {
        pg.fill(color(255, 0, 0));
        float y = Translate(data.get(i).val);
        data.get(i).graph_x = xPos;
        data.get(i).graph_y = y;
        data.get(i).display(pg);
        //text(data.get(i).val, xPos, y-10);
        //println("xPos", xPos);
        if (i-1 >= 0 && data.get(i).hasData()) {
          pg.stroke(color(255, 0, 0));
          pg.line(data.get(i).graph_x, data.get(i).graph_y, data.get(i-1).graph_x, data.get(i-1).graph_y);
        }
      }
      xPos += xstep;
    }
  }
  void display() {
    if (graphChanged) {
      pg.beginDraw();
      pg.background(0);
      drawGridLines();
      drawData();
      pg.endDraw();
      graphChanged = false;
    } else {
      image(pg, 0, 0);
    }
  }
}
