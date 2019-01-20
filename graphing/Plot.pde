class Plot extends PlotObject {
  //Where the data points are stored
  ArrayList<DataPoint> data;
  //scale factor to convert from y value to graph y value
  float scale;
  //boolean to see if we need to update our PGraphics object or not
  boolean graphChanged = true;
  //Used to see if we need to find the point of intersection
  float prevMouseX = mouseX;
  float prevMouseY = mouseY;
  //Used to display highlighted ellipse
  DataPoint lastIntersectedPoint = null;
  Plot() {
    miny = 0.0;
    maxy = 0.0;
    minx = 0;
    maxx = 0;
    scale = 0.0;
    data = new ArrayList<DataPoint>();
    pg = createGraphics(width, height);
  }

  //loads data in to be processed
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
  //Ability to set the min and max x value
  void SetXAxis(float minxx, float maxxx) {
    minx = minxx;
    maxx = maxxx;
  }  
  //Ability to limit the min and max y value shown
  void SetYAxis(float minyy, float maxyy) {
    //TODO: need a way to just change the viewing y here
    miny = minyy;
    maxy = maxyy;
    SetScale();
  }
  //Updated the scale factor when miny and maxy change
  void SetScale() {
    scale = (rcy-lcy)/(maxy-miny);
  }

  //Translate y value into graph y value
  float Translate(float point) {
    float val = (point-miny)*scale + lcy;
    return val;
  }
  //Draws data points to our PGraphics object
  void drawData() {
    float xPos = lcx;
    float xstep = w/(data.size()-1);
    //pg.fill(color(255, 0, 0));
    boolean prevHasData = false;
    if (data.get(0).hasData()) {
      drawPoint(data.get(0), xPos);
      prevHasData = true;
    }
    DataPoint prev = data.get(0);
    xPos += xstep;
    for (int i = 1; i < data.size(); ++i) {
      DataPoint cur = data.get(i); 
      if (cur.hasData()) {
        drawPoint(cur, xPos);
        if (prevHasData) {
          //pg.stroke(color(255, 0, 0));
          pg.line(cur.graph_x, cur.graph_y, prev.graph_x, prev.graph_y);
        } 
        prevHasData = true;
        prev = cur;
      } else {
        prevHasData = false;
      }
      xPos += xstep;
    }
  }
  void drawPoint(DataPoint d, float x) {
    d.graph_x = x;
    d.graph_y = Translate(d.val);
    d.display(pg);
  }
  //Display method called from main loop that determines if we need to update our PGraphics object
  void display() {
    if (graphChanged) {
      println("changed");
      //pg.beginDraw();
      //pg.background(0);
      //drawGridLines();
      drawData();
      //pg.endDraw();
      graphChanged = false;
      println("done");
    }
    //} else {
    //  image(pg, 0, 0);
    //}
  }
  void drawHighlightedPoint() {
    fill(255);
    ellipse(lastIntersectedPoint.graph_x, lastIntersectedPoint.graph_y, 
      lastIntersectedPoint.pointSize*3, lastIntersectedPoint.pointSize*3);
  }
  //Used for highlighting point on graph in main loop
  //Point lookup needs to be optimized
  void checkMouseIntersection() {
    boolean intersect = false;
    if (mouseX == prevMouseX && mouseY == prevMouseY 
      && lastIntersectedPoint != null
      && lastIntersectedPoint.intersectMouse()) {
      //println("no change");
      intersect = true;
    } else {
      //println("change");
      for (DataPoint p : data) {
        if (p.intersectMouse()) {
          prevMouseX = mouseX;
          prevMouseY = mouseY;
          lastIntersectedPoint = p;
          intersect = true;
          break;
        }
      }
    }
    if (intersect) {
      drawHighlightedPoint();
    }
  }
}
