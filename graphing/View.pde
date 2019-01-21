static class View {
  //Used to determine the new corner values
  float lcx, lcy, rcx, rcy;
  //Used to save image view
  PGraphics pg;
  //Used to keep track of start and end indicies
  int startidx, endidx;
  //Used to get view cnt
  int cnt = 0;
  View(float llcx, float llcy, float rrcx, float rrcy) {
    lcx = min(llcx, rrcx);
    lcy = max(llcy, rrcy);
    rcx = max(llcx, rrcx);
    rcy = min(llcy, rrcy);
    ++cnt;
  }
  void updateIndexRange(int si, int ei) {
    startidx = si;
    endidx = ei;
  }
}
