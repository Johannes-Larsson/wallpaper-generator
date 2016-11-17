class Point {
  public int x, y;
  public Point(int x, int y) {
    this.x  = x;
    this.y = y;
  }
  public String toString() {
    return "(" + x + ", " + y + ")"; 
  }
}

Point[][] points;
// point layout
int wd = 10;
int hd = 10;
int r = 50;

// coloring
int h = 0;
int s = 100;
int b = 200;

int hx = 4;
int sx = 0;
int bx = 0;

int hy = -3;
int sy = 5;
int by = 0;


boolean drawParams;

void setup() {
  size(1000, 500);
  colorMode(HSB, 255);
  //noLoop();
  generatePoints();
}

void generatePoints() {
  points = new Point[wd][hd];
  for (int x = 0; x < wd; x++) {
    for (int y = 0; y < hd; y++) {
      points[x][y] = new Point(
      x == 0 ? 0 : x == wd - 1 ? width : (int)random(-r, r) + x * width / wd, 
      y == 0 ? 0 : y == hd - 1 ? height : (int)random(-r,  r) + y * height / hd);
    }
  }
  drawImage();
}

void keyPressed() {
  println(key);
  
  if (key == ENTER) saveFrame("image.png");
  
  if (key == 'p') drawParams = !drawParams;
  
  
}

void drawParams() {
  println("wef");
  stroke(0);
  fill(0);
  c = 0;
  param("x divisions", wd);
  param("y divisions", hd);
  
  param("base hue", h);
  param("base saturation", s);
  param("base brightness", b);
  
  param("x hue", hx);
  param("x saturation", sx);
  param("x brightness", bx);
  
  param("y hue", hy);
  param("y saturation", sy);
  param("y brightness", by);
}

int c;
void param(String name, int val) {
  println(name);
  text(name + ": " + val, 100, 100 + c * 20);
  c++;
}

void drawImage() {
  for (int x = 0; x < wd - 1; x++) {
    for (int y = 0; y < hd - 1; y++) {
      int c = color(hy * y + hx * x + h, sy * y + sx * x + s, by * y + bx * x + b);
      fill(c);
      stroke(c);
      beginShape();
      vertex(points[x][y].x, points[x][y].y);
      vertex(points[x + 1][y].x, points[x + 1][y].y);
      vertex(points[x + 1][y + 1].x, points[x + 1][y + 1].y);
      vertex(points[x][y + 1].x, points[x][y + 1].y);
      endShape();
    }
  }
}

void draw() {
  background(0);
  drawImage();
  if (drawParams) drawParams();
}