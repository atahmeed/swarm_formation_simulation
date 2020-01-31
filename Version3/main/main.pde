//version 3
ArrayList<Vehicle> vehicles;  //Array of robot objects
int n = 10;                   //number of robots in the system
float rad = 0;                // radius of rendezvous circle
float centroidx=0, centroidy=0;// coordinate points of the centroid

void setup() {
  size(1000, 1000);    // define canvase size

  // create a list of vehicles and add vehicles at random positions
  vehicles = new ArrayList<Vehicle>();
  for (int i=0; i<n; i++)
  {
    vehicles.add(new Vehicle(random(1000), random(1000)));
  }
  Vehicle temp = vehicles.get(0);
  float tempsr = temp.SR;
  float circumference = tempsr*1.35*n;
  rad = circumference/(2*PI);
}

void draw() {
  // show the circle around the centroid
  background(255);
  fill(255);
  stroke(0);
  strokeWeight(2);
  ellipse(centroidx, centroidy, rad*2, rad*2);

  centroid(); // calculate centroid position at each iteration

  // iterate through the robots and seek the centroid position
  for (Vehicle v : vehicles) {               

    {
      v.seek(new PVector(centroidx, centroidy), rad, vehicles);
      v.update();

      v.display();
    } 

    // show the centroid text
    textSize(20);
    text("Centroid", centroidx, centroidy);
    ellipse(centroidx, centroidy, 5, 5);
    fill(0);
  }
}
void centroid() {
  float x=0, y=0;
  for (Vehicle v : vehicles)
  {
    x+=v.position.x;
    y+=v.position.y;
  }
  centroidx=x/n;
  centroidy=y/n;
}
