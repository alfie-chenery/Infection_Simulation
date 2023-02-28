Float INFECTION_RATE = 0.2;
Float RECOVER_RATE = 0.1;

ArrayList<Particle> Population;
ArrayList<PVector> Spoints;
ArrayList<PVector> Ipoints;
ArrayList<PVector> Rpoints;
int S = 9999;
int I = 1;
int R = 0;
int iteration = 0;
boolean loop = true;

void setup(){
  size(1600,600);
  noFill();
  Population = new ArrayList<Particle>();
  Spoints = new ArrayList<PVector>();
  Ipoints = new ArrayList<PVector>();
  Rpoints = new ArrayList<PVector>();
  for(int i=0; i<10000; i++){
    float X = 50+(i%100)*5;
    float Y = 50+(floor(i/100))*5;
    Particle p = new Particle(new PVector(X,Y));
    Population.add(p);
  }
  Population.get(0).infect();


}

void draw(){
  background(0);
  
  //population
  for(Particle p : Population){
    p.move();
    p.render(); 
  }
  
  if(loop==false){
    noLoop(); 
  }
 
  
  if(frameCount%150==0){
    for(Particle p : Population){
      p.spreadInfection(); 
      p.recover();
    }
    
    S = 0;
    I = 0;
    R = 0;
    for(Particle p : Population){
      if(p.suceptable){
        S++; 
      }else if(p.infected){
        I++;
      }else{ //p.recovered
        R++; 
      }
    }
    Spoints.add(new PVector(600+(iteration*10),550-(S/25)));
    Ipoints.add(new PVector(600+(iteration*10),550-(I/25)));
    Rpoints.add(new PVector(600+(iteration*10),550-(R/25)));
    iteration++;
    if(I==0){
      loop = false; 
    }
  }
  
  if(frameCount%150==30){
    randomise();
  }
  
  //graph
  strokeWeight(2);
  stroke(255);
  beginShape();
  for(PVector p : Spoints){
    vertex(p.x,p.y);
  }
  endShape();
  stroke(255,0,0);
  beginShape();
  for(PVector p : Ipoints){
    vertex(p.x,p.y);
  }
  endShape();
  stroke(0,255,0);
  beginShape();
  for(PVector p : Rpoints){
    vertex(p.x,p.y);
  }
  endShape();
  
  strokeWeight(3);
  stroke(255);
  line(600,50,600,550);
  line(600,550,1550,550);
  
  textSize(24);
  fill(255);
  text("Suceptable: " + S + " (" + float(S)/100 + "%)", width-350,50);
  fill(255,0,0);
  text("Infected: " + I + " (" + float(I)/100 + "%)", width-350,80);
  fill(0,255,0);
  text("Recovered: " + R + " (" + float(R)/100 + "%)", width-350,110);
  noFill();
}

void randomise(){
  
  IntList indexes = new IntList();
  for(int i=0; i<10000; i++){
    indexes.append(i); 
  }
  indexes.shuffle();

  
  for(int j=0; j<Population.size(); j++){
    Population.get(j).setTarget(indexes.get(j));
  }

}
