class PlotManager extends PlotObject {
  //Used to determine when to update image
  boolean windowChanged = true;
  //Used to keep all graphics in memory
  ArrayList<Plot> plots;
  //Colors to display graphs
  color[] colors;
  //Used to simplify axis drawing
  Axis axis;
  //Used to keep a stack of views
  ArrayList<View> views;
  PlotManager(ArrayList<ArrayList<DataPoint>> d) {
    plots = new ArrayList<Plot>();
    axis = new Axis(d.size());
    pg = createGraphics(width, height);
    maxy = Integer.MIN_VALUE;
    miny = Integer.MAX_VALUE;

    int eidx = 0;
    for (ArrayList<DataPoint> dd : d) {
      Plot p = new Plot();
      p.SetData(dd);
      maxy = max(maxy, p.maxy);
      miny = min(miny, p.miny);
      plots.add(p);
      eidx = max(eidx, dd.size());  //take max point
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
    views = new ArrayList<View>();
    views.add(new View(lcx, lcy, rcx, rcy));
    startidx = 0;
    endidx = eidx;
  }
  void SetYAxis(float newminy, float newmaxy) {
    axis.SetYAxis(newminy, newmaxy);
    for (Plot p : plots) {
      p.SetYAxis(newminy, newmaxy);
    }
  }
  void SetXAxis(float newminx, float newmaxx) {
    axis.SetXAxis(newminx, newmaxx);
    for (Plot p : plots) {
      p.SetXAxis(newminx, newmaxx);
    }
  }
  void UpdateGraph() {
    windowChanged = true;
    for (Plot p : plots) {
      p.UpdateGraph();
    }
  }
  void addView(View v) {
    //save cur view
    views.get(views.size()-1).pg = pg;
    int sidx = 0;
    int eidx = 0;
    boolean inViewingWindow = false;
    for (int i = 0; i < plots.size(); ++i) {
      for (int j = startidx; j < endidx; ++j) {
        if (!inViewingWindow && plots.get(i).data.get(j).graph_x >= v.lcx) {
          inViewingWindow = true;
          sidx = j;
        }
        if (inViewingWindow && plots.get(i).data.get(j).graph_x > v.rcx) {
          eidx = j-1;
          break;
        }
      }
    }
    println("new start and end", sidx, eidx, startidx, endidx );
    startidx = sidx;
    endidx = eidx;
    v.updateIndexRange(startidx, endidx);
    views.add(v);
    println("added view", v.cnt);
    UpdateGraph();
  }
  void popView() {
    if (views.size() > 1) {
      views.remove(views.size()-1);
      View cur = views.get(views.size()-1);
      startidx = cur.startidx;
      endidx = cur.endidx;
      if (pg == cur.pg) {
        println("same image?");
      }
      pg = cur.pg;
    } else {
      println("can't pop anymore");
    }
  }
  void display() {
    if (windowChanged) {
      pg.beginDraw();
      pg.clear();
      pg.background(0);
      axis.pg = pg;
      axis.display();
      println("num plots: ", plots.size());
      for (int i = 0; i < plots.size(); ++i) {
        println("drawing plot ", i);
        pg.fill(colors[i]);
        pg.stroke(colors[i]);
        plots.get(i).pg = pg;
        plots.get(i).startidx = startidx;
        plots.get(i).endidx = endidx;
        plots.get(i).display();
      }
      pg.endDraw();
      windowChanged = false;
      views.get(views.size()-1).pg = pg;
    }
    image(pg, 0, 0);
  }
  void checkMouseIntersection() {
    for (Plot p : plots) {
      p.checkMouseIntersection();
    }
  }
}
