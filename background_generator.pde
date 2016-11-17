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

int[] params = new int[12];

int i = 0;

// point layout
int wd = i++;
int hd = i++;
int r = i++;

// coloring
int h = i++;
int s = i++;
int b = i++;

int hx = i++;
int sx = i++;
int bx = i++;

int hy = i++;
int sy = i++;
int by = i++;



boolean drawParams;

void setup() {
  size(1920, 1080);
  colorMode(HSB, 255);
  
  i = 0;

  params[wd] = 10;
  params[hd] = 10;
  params[r] = 50;
  
  params[b] = 50;
  
  generatePoints();
}

void generatePoints() {
  points = new Point[params[wd]][params[hd]];
  for (int x = 0; x < params[wd]; x++) {
    for (int y = 0; y <params[hd]; y++) {
      points[x][y] = new Point(
      x == 0 ? 0 : x == params[wd] - 1 ? width : (int)random(-params[r], params[r]) + x * width / params[wd], 
      y == 0 ? 0 : y == params[hd] - 1 ? height : (int)random(-params[r],  params[r]) + y * height / params[hd]);
    }
  }
  drawImage();
}

void keyPressed() {
  println(key);
  
  if (key == ENTER) saveFrame("image.png");
  
  if (key == 'p') drawParams = !drawParams;
  
  if (keyCode == UP && i > 0) {
    i--;
    println("up");
  }
  if (keyCode == DOWN && i < params.length - 1) {
    i++;
    println("down");
  }
  if (keyCode == LEFT) {
    params[i] --;
    if (i < 3) generatePoints();
  }
  if (keyCode == RIGHT) {
    params[i] ++;
    if (i < 3) generatePoints();
  }
}

void drawParams() {
  stroke(0);
  fill(0);
  c = 0;
  param("x divisions", wd);
  param("y divisions", hd);
  param("point randomness", r);
  
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
void param(String name, int index) {
  //println(name);
  text((index == i ? ">" : " ") + name + ": " + params[index], 100, 100 + c * 20);
  c++;
}

void drawImage() {
  for (int x = 0; x < params[wd] - 1; x++) {
    for (int y = 0; y < params[hd] - 1; y++) {
      int c = color(params[hy] * y + params[hx] * x + params[h], params[sy] * y + params[sx] * x + params[s], params[by] * y + params[bx] * x + params[b]);
      fill(c);
      stroke(c);
      beginShape();
      vertex(points[x][y].x - 1, points[x][y].y - 1);
      vertex(points[x + 1][y].x + 1, points[x + 1][y].y - 1);
      vertex(points[x + 1][y + 1].x + 1, points[x + 1][y + 1].y + 1);
      vertex(points[x][y + 1].x - 1, points[x][y + 1].y + 1);
      endShape();
    }
  }
}

void draw() {
  background(0);
  drawImage();
  if (drawParams) drawParams();
}