class Particle{
  
  PVector pos;
  PVector vel;
  PVector target;
  int index;
  boolean suceptable;
  boolean infected;
  boolean recovered;
  
  Particle(PVector P){
    pos = P;
    target = P;
    vel = new PVector(0,0);
    suceptable = true;
    infected = false;
    recovered = false;
  }
  
  void infect(){
    if(suceptable){
      suceptable = false;
      infected = true;
      recovered = false;
    }
  }
  
  void recover(){
    if (infected){
      float chance = random(1);
      if (chance<RECOVER_RATE){
        suceptable = false;
        infected = false;
        recovered = true;
      }
    }
  }
  
  
  void setTarget(int i){
    index = i;
    
    int X = 50+(i%100)*5;
    int Y = 50+(floor(i/100))*5;
    target = new PVector(X,Y);
  }
  
  void move(){
    PVector desired = new PVector(target.x-pos.x,target.y-pos.y);
    float distance = desired.mag();
    float speed = distance/15; //change value to affect movement speed
    desired.setMag(speed);
    vel = desired;
  }
    
  void render(){
    pos.add(vel);
    
    strokeWeight(5);
    stroke(255);
    if(infected){
      stroke(255,0,0); 
    }else if(recovered){
      stroke(0,255,0); 
    }
    point(pos.x,pos.y);
  }
  
  void spreadInfection(){
    if(infected){
      for(Particle p : Population){
        if((p.index==index-100)||(p.index==index-1)||(p.index==index+1)||(p.index==index+100)){
          float chance = random(1);
          if (chance<INFECTION_RATE){
            p.infect();
          }
        }
      }
    }
  }
  
}
