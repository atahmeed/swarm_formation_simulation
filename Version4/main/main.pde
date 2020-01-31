//version 4
float book_distance=15.0;
float robot_to_robot_dist=50.0;
ArrayList<Vehicle> vehicles;
ArrayList<Target> TargetPoints;
boolean startSimulation = false;
int n = 10;
float rad = 0.0;

// image variables
PImage S;

void setup() {
  size(1000, 1000);
  TargetPoints = new ArrayList<Target>();
  make('l');
  print(TargetPoints.size());
  vehicles = new ArrayList<Vehicle>();
  for (int i=0; i<n; i++)
  {
    vehicles.add(new Vehicle(random(1000), random(1000)));
  }
}

void draw() {
  background(255);
  //image(S,0,0);
  fill(200);
  stroke(0);
  strokeWeight(2);

  ellipse(mouseX, mouseY, rad*2, rad*2);
  
  for(Vehicle v: vehicles){
    Target shortestPoint = TargetPoints.get(0);
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
  else v.seek(shortestPoint.position,rad,vehicles);
  v.update();
  v.display();
  }
}

void make(char c)
{
  if (c=='v' || c=='V')
  {

    TargetPoints.add(new Target(200, 200));
    TargetPoints.add(new Target(250, 250));
    TargetPoints.add(new Target(300, 300));
    TargetPoints.add(new Target(350, 350));
    TargetPoints.add(new Target(400, 400));
    TargetPoints.add(new Target(450, 450));
    TargetPoints.add(new Target(500, 400));
    TargetPoints.add(new Target(550, 350));
    TargetPoints.add(new Target(600, 300));
    TargetPoints.add(new Target(650, 250));
    TargetPoints.add(new Target(700, 200));
  }
  if (c=='l' || c=='L')
  {


    TargetPoints.add(new Target(200, 250));
    TargetPoints.add(new Target(200, 300));
    TargetPoints.add(new Target(200, 350));
    TargetPoints.add(new Target(200, 400));
    TargetPoints.add(new Target(200, 450));
    TargetPoints.add(new Target(200, 500));
    TargetPoints.add(new Target(200, 550));
    TargetPoints.add(new Target(200, 600));
    TargetPoints.add(new Target(200, 650));
    TargetPoints.add(new Target(200, 700));
    TargetPoints.add(new Target(200, 750));

    TargetPoints.add(new Target(250, 750));
    TargetPoints.add(new Target(300, 750));
    TargetPoints.add(new Target(350, 750));
    TargetPoints.add(new Target(400, 750));
    TargetPoints.add(new Target(450, 750));
    TargetPoints.add(new Target(500, 750));
  }
  if (c=='i' || c=='I')
  {
    TargetPoints.add(new Target(400, 250));
    TargetPoints.add(new Target(400, 300));
    TargetPoints.add(new Target(400, 350));
    TargetPoints.add(new Target(400, 400));
    TargetPoints.add(new Target(400, 450));
    TargetPoints.add(new Target(400, 500));
    TargetPoints.add(new Target(400, 550));
    TargetPoints.add(new Target(400, 600));
    TargetPoints.add(new Target(400, 650));
    TargetPoints.add(new Target(400, 700));
    TargetPoints.add(new Target(400, 750));
  }
  if (c=='t' || c=='T')
  {
    TargetPoints.add(new Target(200, 250));
    TargetPoints.add(new Target(250, 250));
    TargetPoints.add(new Target(300, 250));
    TargetPoints.add(new Target(350, 250));
    TargetPoints.add(new Target(400, 250));
    TargetPoints.add(new Target(450, 250));

    TargetPoints.add(new Target(350, 300));
    TargetPoints.add(new Target(350, 350));
    TargetPoints.add(new Target(350, 400));
    TargetPoints.add(new Target(350, 450));
    TargetPoints.add(new Target(350, 500));
    TargetPoints.add(new Target(350, 550));
  }
}
void mousePressed()
{
  vehicles.add(new Vehicle(mouseX, mouseY));
}
void keyPressed()
{
  if(key=='l')
  {
    TargetPoints.clear();
    make('l');
    refresh_vehicles(vehicles);
  }
  else if(key=='t')
  {
    TargetPoints.clear();
    make('t');
    refresh_vehicles(vehicles);
  }
  else if(key=='i')
  {
    TargetPoints.clear();
    make('i');
    refresh_vehicles(vehicles);
  }
  else if(key=='v')
  {
    TargetPoints.clear();
    make('v');
    refresh_vehicles(vehicles);
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
