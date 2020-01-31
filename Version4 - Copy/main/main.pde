//version 4
float book_distance=15.0;
float robot_to_robot_dist=50.0;
ArrayList<Vehicle> vehicles;
ArrayList<Target> TargetPoints;
boolean startSimulation = false;
int n = 0;
float rad = 0.0;
int canvas[][];
// image variables
PImage S;
PrintWriter output;
int it=1;
void setup() {
  size(1000, 1000);
  canvas = new int[width][height];
  //S = loadImage("random.bmp");
  //S = loadImage("human.bmp");
  //S = loadImage("M.bmp");
  S = loadImage("S.bmp");
  output = createWriter("S.csv"); 
  TargetPoints = new ArrayList<Target>();
  for(int x=0;x<width;x+=1)
  {
    for(int y=0;y<height;y+=1)
    {
        canvas[x][y]=0;
       if(S.get(x,y) == #000000)
       { 
         for(int p=-60;p<=60;p++)
         {
           for(int q=-60;q<=60;q++)
           {
             S.set(x+p,y+q,#ffffff);
           }
         }
         TargetPoints.add(new Target(x,y));

       }

    }
  }

  print(TargetPoints.size());

  
  n=TargetPoints.size();
  vehicles = new ArrayList<Vehicle>();
  for (int i=0; i<n; i++)
  {
    vehicles.add(new Vehicle(random(1000), random(1000)));
  }
}

void draw() {
  background(255);
  image(S,0,0);
  fill(200);
  stroke(0);
  strokeWeight(2);
  for(Target t:TargetPoints)
  {
    fill(255,0,0);
    ellipse(t.position.x,t.position.y,4,4);
  }
  float avgerr=0;
  for(Vehicle v: vehicles){
    Target shortestPoint = TargetPoints.get(0);
    if(int(v.position.x)>0 && int(v.position.x)<width && int(v.position.y)>0 && int(v.position.y)<height) 
    canvas[int(v.position.x)][int(v.position.y)]=1;
    if(!v.booked)
    {
      float shortestLength=10000.0;
      for(int qindx = 0;qindx<TargetPoints.size();qindx++)
      {
        Target p = TargetPoints.get(qindx);
        if(!p.booked)
        {
          float distance = v.position.dist(p.position);
          if(distance<book_distance && p.booked==false)
          {
            p.booked=true;
            p.booked_by = v;
            v.booked = true;
            v.booked_at= p.position;
            
          }
          else if(distance<shortestLength)
          {
            shortestPoint = p;
            shortestLength= distance;
          }
        }
      }
    }
  if(v.booked)
  {
    v.seek(v.booked_at,rad,vehicles);
  }
  else{ 
    v.booked=true;
    v.booked_at=shortestPoint.position;
    shortestPoint.booked=true;
    shortestPoint.booked_by=v;
    v.seek(shortestPoint.position,rad,vehicles);
  }
  v.update();
  v.display();
  avgerr+= PVector.dist(v.position,v.booked_at)/n;
  }
  output.println(it+","+avgerr);
  it+=1;
  println(avgerr);
  for(int i=0;i<width;i+=1)
    for(int j=0;j<height;j+=1)
      if(canvas[i][j]==1) 
        {
          strokeWeight(1.5);
          stroke(0,0,255);
          point(i,j);
        }
  
}

void keyPressed() {
  if(key=='q'){
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program
  }
}
void refresh_vehicles(ArrayList<Vehicle> vs)
{
  for(Vehicle v:vs)
  {
    v.booked=false;
    v.booked_at = null;
  }
}
