//version 2
ArrayList<Vehicle> vehicles;
int n = 15;
float centroidx=0,centroidy=0; 
void setup() {
  size(1000,1000);
  
  vehicles = new ArrayList<Vehicle>();
  for(int i=0;i<n;i++)
  {
    vehicles.add(new Vehicle(random(1000),random(1000)));
  }
}

void draw() {
  background(255);
  
  fill(200);
  stroke(0);
  strokeWeight(2);
  
  ellipse(centroidx,centroidy,200,200);
  centroid();
  for(Vehicle v: vehicles){
  v.seek(new PVector(centroidx,centroidy));
  v.update();
  v.display();
  }
}
void centroid(){
  float x=0,y=0;
  for(Vehicle v:vehicles)
  {
    x+=v.position.x;
    y+=v.position.y;
  }
  centroidx=x/n;
  centroidy=y/n;
}
