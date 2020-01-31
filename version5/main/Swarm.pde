class Swarm {
  int n_robots;
  int robrob_distance=60;
  ArrayList<Vehicle> vehicles;
  ArrayList<Target> TargetPoints;
  float book_distance=15.0;
  float heading;
  float spreadAngle=2*(PI-(PI/2+PI/4));
  float patternRad = 100;
  PVector centroid;
  Vehicle leader;
  int canvas[][];
  //boolean isLeaderChosen;
  int k=0;
  float avgerr=0;
  Swarm(int n)
  {
    canvas = new int[width][height];
    heading=0.0;
    //isLeaderChosen=false;
    n_robots=n;
    vehicles = new ArrayList<Vehicle>();
    for (int i=0; i<n_robots; i++)
      vehicles.add(new Vehicle(random(-500, 500), random(-500, 500)));
    TargetPoints= new ArrayList<Target>();
    centroid = new PVector(0, 0);
    spreadAngle = PI/2;
  }
  //void matchHeading()
  //{
  //  PVector h = PVector.fromAngle(heading);
  //  h.setMag(0);
  //  for (Vehicle v : vehicles)
  //  {
  //    v.velocity = h;
  //  }
  //}
  void generateRandomFormationPoints()
  {
    for (int i=0; i<n_robots; i++)
      TargetPoints.add(new Target(random(-500, 500), random(-500, 500)));
  }
  void calculateCentroid()
  {

    float x=0, y=0;
    for (Vehicle v : vehicles)
    {
      x+= v.position.x;
      y+= v.position.y;
    }
    centroid.x=x/n_robots;
    centroid.y=y/n_robots;
    //centroid.x=0;
    //centroid.y=0;
    print(centroid.x, centroid.y);
  }
  void displayTargetPoints()
  {
    for (Target t : TargetPoints)
    { 
      fill(0);
      stroke(0);
      strokeWeight(3);
      ellipse(t.position.x, t.position.y, 10, 10);
    }
  }

  boolean isAllCenter()
  {
    calculateCentroid();
    println(centroid.x, centroid.y);
    for (Vehicle v : vehicles)
      if (PVector.dist(v.position, centroid)>500.00) return false;
    return true;
  }
  void makeFormation(String shape, PVector c)
  {
    centroid=c;
    refresh_vehicles(vehicles);
    TargetPoints.clear();
    
    if (shape=="line")
    {
      TargetPoints.add(new Target(centroid.x, centroid.y));
      for (int i=0; i<n_robots-1; i++)
      {
        int newmag = robrob_distance*((i/2)+1);
        PVector p = PVector.fromAngle(heading+ (pow(-1, i)*PI/2));
        p.setMag(newmag);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    } else if (shape=="arrow")
    {
      TargetPoints.add(new Target(centroid.x, centroid.y));
      for (int i=0; i<n_robots-1; i++)
      {
        int newmag = robrob_distance*((i/2)+1);
        PVector p = PVector.fromAngle(heading+ (pow(-1, i)*spreadAngle/2));
        p.setMag(newmag);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    }
    else if(shape=="circle")
    {
      float angleDiff = 2*PI/n_robots;
      for (int i=0; i<n_robots; i++)
      {
        PVector p = PVector.fromAngle(heading+ i*angleDiff);
        p.setMag(patternRad);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    }
  }
  void makeFormation(String shape)
  {
    calculateCentroid();

    refresh_vehicles(vehicles);
    TargetPoints.clear();
    if (shape=="line")
    {
      TargetPoints.add(new Target(centroid.x, centroid.y));
    
      for (int i=0; i<n_robots-1; i++)
      {
        int newmag = robrob_distance*((i/2)+1);
        PVector p = PVector.fromAngle(heading+ (pow(-1, i)*PI/2));
        p.setMag(newmag);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    } else if (shape=="arrow")
    {
      TargetPoints.add(new Target(centroid.x, centroid.y));
    
      for (int i=0; i<n_robots-1; i++)
      {
        int newmag = robrob_distance*((i/2)+1);
        PVector p = PVector.fromAngle(heading+ (pow(-1, i)*spreadAngle/2));
        p.setMag(newmag);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    }
    else if(shape=="circle")
    {
      float angleDiff = 2*PI/n_robots;
      for (int i=0; i<n_robots; i++)
      {
        PVector p = PVector.fromAngle(heading+ i*angleDiff);
        p.setMag(patternRad);
        PVector q=PVector.add(centroid, p);
        TargetPoints.add(new Target(q.x, q.y));
      }
    }
  }

  boolean allSettled()
  {
    for (Vehicle v : vehicles)
      if (!v.booked) return false;
    return true;
  }

  void refresh_vehicles(ArrayList<Vehicle> vs)
  {
    for (Vehicle v : vs)
    {
      v.booked=false;
      v.booked_at = null;
    }
  }
  void displayBots()
  {
    for (Vehicle v : vehicles) {
      v.update();
      v.display();
    }
  }
  
  
  void printPath(){
   for(int i=0;i<width;i+=1)
    for(int j=0;j<height;j+=1)
      if(canvas[i][j]==1) 
        {
          strokeWeight(1.5);
          stroke(0,0,255);
          point(i-width/2,j-width/2);
        }
      
  }
  void makeFormationFromPoints()
  {
    fill(0);
    noStroke();
    //ellipse(centroid.x, centroid.y, 10, 10); 
    avgerr=0;
    if (TargetPoints.size()!=0)
    {
      for (Vehicle v : vehicles) {
        Target shortestPoint = TargetPoints.get(0);
        if (!v.booked)
        {
          float shortestLength=10000.0;
          for (int qindx = 0; qindx<TargetPoints.size(); qindx++)
          {
            Target p = TargetPoints.get(qindx);
            if (!p.booked)
            {
              float distance = v.position.dist(p.position);
              if (distance<book_distance && p.booked==false)
              {
                p.booked=true;
                p.booked_by = v;
                v.booked = true;
                v.booked_at= p.position;
              } else if (distance<shortestLength)
              {
                shortestPoint = p;
                shortestLength= distance;
              }
            }
          }
        }
        if (v.booked)
        {
          v.seek(v.booked_at, vehicles);
        } else{
          v.booked=true;
          v.booked_at=shortestPoint.position;
          shortestPoint.booked=true;
          shortestPoint.booked_by=v;
          v.seek(shortestPoint.position, vehicles);
        }
        avgerr+= PVector.dist(v.position,v.booked_at)/n_robots;
        if(int(v.position.x)>-width/2 && int(v.position.x)<width/2 && int(v.position.y)>-height/2 && int(v.position.y)<height/2)
        canvas[int(v.position.x+width/2)][int(v.position.y+height/2)]=1;
      }
    }
    println(avgerr);
  }
}
