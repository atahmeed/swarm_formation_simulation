class Vehicle {
  float rad=0.0;
  boolean booked=false;
  PVector booked_at;
  boolean alone = true;
  float SR=35;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float kp=0.1;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    position = new PVector(x,y);
    r = 6;
    maxspeed = 2.5;
    maxforce = 1.2;
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

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates .a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target, ArrayList<Vehicle> vehicles) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    float dist = desired.mag()-rad;
    
    float m = dist*kp;
    desired.setMag(m);
    
    PVector steer = PVector.sub(desired,velocity);
    
    PVector total = PVector.add(steer,avoid(vehicles));
    
    applyForce(total.limit(maxforce));
  }
    
  void display() {
    // Draw a triangle rotated in the direction of velocity
    //if(alone)
    //  noFill();
    //else
    //  fill(128,0,0);
    //strokeWeight(0);
    //ellipse(position.x,position.y,SR*2,SR*2);
    float theta = velocity.heading2D() + PI/2;
    fill(240,55,105);
    stroke(0);
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
  
  PVector avoid(ArrayList<Vehicle> vehicles)
  {
    alone = true;
    PVector S = new PVector(0,0);
    for(Vehicle v:vehicles)
    {
      if(v.position != position && position.dist(v.position)<SR)
      {
        alone=false;
        S.add(PVector.sub(position,v.position));
      }
    }
    //return S.rotate(PI/2);
    return S;
  }
}
