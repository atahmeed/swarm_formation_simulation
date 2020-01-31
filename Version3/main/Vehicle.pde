// The "Vehicle" class representing the robots

class Vehicle {
  float SR=40;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float kp=0.1;      // proportionality constant for go-to-goal behaviour
  float r;           // determining the size of the robot vehicles      
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    position = new PVector(x,y);
    r = 6;
    maxspeed = 2;
    maxforce = 0.1;
  }

  // Method to update position 
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }
  // Method to apply steering or other types of force on the robots
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target, float radius,ArrayList<Vehicle> vehicles) {
    // A vector pointing from the position to the target
    PVector desired = PVector.sub(target,position);  
    float dist = desired.mag()-radius;
    
    float m = dist*kp;
    desired.setMag(m);
    
    PVector steer = PVector.sub(desired,velocity);
    steer = PVector.add(steer.mult(0.4),avoid(vehicles).mult(0.6));
    applyForce(steer);
  }
   // method to display each robot vehicle
  void display() {
    // Draw a triangle rotated in the direction of velocity
    noFill();
    ellipse(position.x,position.y,SR*2,SR*2);
    float theta = velocity.heading2D() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  // avoid robots behaviour
  PVector avoid(ArrayList<Vehicle> vehicles)
  {
    PVector avoid_vel = new PVector(0,0);  // initialize with a null vector
    for(Vehicle v:vehicles)
    {
      // if any other robot is very close to the robot
      if(v.position != position && position.dist(v.position)<SR+10) 
      {
        // add avoiding velocity with respect to 
        // that robot to the avoid_vel vector
        avoid_vel.add(PVector.sub(position,v.position));                     
      }
    }
    return avoid_vel;
  }
}
