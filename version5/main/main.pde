//version 5
Swarm S;
//int canvas[][];
int n = 11;
int i=0, settled=0, prev_settled=0;
String shape="circle";
void setup() {
  size(1000, 1000);
  S = new Swarm(n);  
  S.makeFormation(shape);
}
int t1=0,t2=0,totalTime=0;
void draw() {
  t1=t2;
  translate(width/2, height/2);
  background(255);
  S.makeFormationFromPoints();
  //S.displayTargetPoints();
  S.printPath();
  S.displayBots();
  t2=millis();
  totalTime+=t2-t1;
  if(!S.allSettled()) println(float(totalTime)/1000);
  //S.printPath(canvas);
  //println(S.TargetPoints.size());
}

void keyPressed()
{
  PVector newcentroid =new PVector();
  if (key=='d' || key=='D') {
    newcentroid.x=S.centroid.x+5;
    newcentroid.y=S.centroid.y;
    S.makeFormation(shape, newcentroid);
  }
  if (key=='a' || key=='A') {
    newcentroid.x=S.centroid.x-5;
    newcentroid.y=S.centroid.y;
    S.makeFormation(shape, newcentroid);
  }
  if (key=='w' || key=='W') {
    newcentroid.x=S.centroid.x;
    newcentroid.y=S.centroid.y-5;
    S.makeFormation(shape, newcentroid);
  }
  if (key=='s' || key=='S') {
    newcentroid.x=S.centroid.x;
    newcentroid.y=S.centroid.y+5;
    S.makeFormation(shape, newcentroid);
  }
  if (key=='[') {
    S.heading+=0.01;  
    S.makeFormation(shape, S.centroid);
  }
  if (key==']') {
    S.heading-=0.01;  
    S.makeFormation(shape, S.centroid);
  }
  if (key=='b') {
    S.spreadAngle-=0.06;  
    S.patternRad-=5;
    S.makeFormation(shape, S.centroid);
  }
  if (key=='n') {
    S.spreadAngle+=0.06;  
    S.patternRad+=5;
    S.makeFormation(shape, S.centroid);
  }
}
