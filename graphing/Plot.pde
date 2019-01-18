class Plot {
  ArrayList<DataPoint> data;
  float miny, maxy;
  float minx, maxx;
  float lcx, lcy, rcx, rcy;      //TODO: rename
  float scale;
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
    scale = 0.0;
    w = width-2*width*p;
    h = height-2*height*p;
    data = new ArrayList<DataPoint>();
    pg = createGraphics(width, height);
  }

  void SetData(ArrayList<DataPoint> d) {
    println("here");
    data = d;
    minx = 0;
    maxx = data.size();
    miny = Integer.MAX_VALUE;
    maxy = Integer.MIN_VALUE;

    println(data.size());
    for (int i = 0; i < data.size(); ++i) {
      if (i%1000000 == 0) {
        println(i);
      }
      if (data.get(i).hasData()) {
        miny = min(miny, data.get(i).val);
        maxy = max(maxy, data.get(i).val);
      }
    }
    println(miny, maxy);
    SetScale();
  }
  void SetXAxis(float minxx, float maxxx) {
    minx = minxx;
    maxx = maxxx;
  }  
  void SetYAxis(float minyy, float maxyy) {
    //TODO: need a way to just change the viewing y here
    miny = minyy;
    maxy = maxyy;
    SetScale();
  }
  void SetScale() {
    scale = (rcy-lcy)/(maxy-miny);
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
    //println(maxy, miny, rcy, lcy, scale);
    float val = (point-miny)*scale + lcy;
    return val;
  }
  void drawData() {
    float xPos = lcx;
    float xstep = w/(data.size()-1);
    pg.fill(color(255, 0, 0));
    boolean prevHasData = false;
    if (data.get(0).hasData()) {
      drawPoint(data.get(0), xPos);
      prevHasData = true;
    }
    DataPoint prev = data.get(0);
    xPos += xstep;
    for (int i = 1; i < data.size(); ++i) {
      if (i % 100000 == 0) {
        println(i);
      }
      DataPoint cur = data.get(i);
      boolean curHasData = cur.hasData(); 
      if (curHasData) {
        drawPoint(cur, xPos);
        if (prevHasData) {
          pg.stroke(color(255, 0, 0));
          pg.line(cur.graph_x, cur.graph_y, prev.graph_x, prev.graph_y);
        }
        prevHasData = curHasData;
      }
      prev = cur;
      xPos += xstep;
    }
  }
  void drawPoint(DataPoint d, float x) {
    d.graph_x = x;
    d.graph_y = Translate(d.val);
    d.display(pg);
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
  void checkMouseIntersection() {
    for (DataPoint p : data) {
      if (p.intersectMouse()) {
        fill(255);
        ellipse(p.graph_x, p.graph_y, p.pointSize*5, p.pointSize*5);
        break;
      }
    }
  }
}
