int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  randomSeed(seed);

  background(0);

  ArrayList<PVector> quads = new  ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));
  int sub = int(random(8000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size()*random(0.1)));
    PVector q = quads.get(ind);
    int cc = int(random(2, 5));
    float ms = q.z/cc;
    for (int dy = 0; dy < cc; dy++) {
      for (int dx = 0; dx < cc; dx++) {
        quads.add(new PVector(q.x+dx*ms, q.y+dy*ms, ms));
      }
    }
    quads.remove(ind);
  }

  noFill();
  stroke(255);
  noStroke();
  PVector q;
  for (int i = 0; i < quads.size(); i++) {
    q = quads.get(i);
    fill((random(1) < 0.5)? 0 : 255);
    fill(rcol());
    rect(q.x, q.y, q.z, q.z);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#34302E, #72574C, #9A4F7D, #488753, #D9BE3A, #D9CF7C, #E2DFDA, #CF4F5C, #368886};
//int colors[] = {#FFFFFF, #000000, #d76280, #f22240};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}