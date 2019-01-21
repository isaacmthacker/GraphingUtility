//Interface for common variables used in plots
abstract class PlotObject {
  //Minimum and maximum y value for viewing
  float miny, maxy;
  //Minimum and maximum x-value
  float minx, maxx;
  //bottom left corner of viewing area x and y
  //top right corner of viewing area x and y
  float lcx, lcy, rcx, rcy;      //TODO: rename
  //scale factor to convert from y value to graph y value
  float scale;
  //width and height of viewing area
  float w, h;
  //percent of window width and height for the viewing area to take up
  float p = 0.025;
  //PGraphics object to draw graph to avoid extra drawing in the main loop
  PGraphics pg;
  //Used to determine which indicies are being drawn
  int startidx, endidx;      //endidx exclusive
  PlotObject() { 
    lcx = width*p;
    lcy = height*(1-p);
    rcx = width*(1-p);
    rcy = height*p;

    w = width-2*width*p;
    h = height-2*height*p;
  }

  abstract void SetYAxis(float newminy, float newmaxy);
  abstract void SetXAxis(float newminx, float newmaxx);
  abstract void display();
}
