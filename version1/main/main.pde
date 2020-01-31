//version 1
ArrayList<Vehicle> vehicles;

void setup() {
  size(500,500);
  int n = 5;
  vehicles = new ArrayList<Vehicle>();
  for(int i=0;i<n;i++)
  {
    vehicles.add(new Vehicle(random(1000),random(1000)));
  }
}

void draw() {
  background(255);

  PVector mouse = new PVector(mouseX, mouseY);

  // Draw an ellipse at the mouse position
  fill(255);
  stroke(0);
  strokeWeight(0);
  ellipse(mouse.x, mouse.y, 200,200);

  // Call the appropriate steering behaviors for our agents
  for(Vehicle v: vehicles){
  v.seek(mouse);
  v.update();
  v.display();
  }
}
