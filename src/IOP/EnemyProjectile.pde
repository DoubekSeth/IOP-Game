class EnemyProjectile {
  PVector location;
  float xPos;
  float yPos;
  float rotation;
  float speed;
  
  int red;
  int green;
  int blue;
  
  EnemyProjectile(float xPos, float yPos, int r, int g, int b) {
    location = new PVector(xPos, yPos);
    xPos = hero.x;
    yPos = hero.y;
    rotation = atan2(yPos - location.y, xPos - location.x) / PI * 180;
    
    red = r;
    green = g;
    blue = b;
    
    speed = 20;
  }
  
  EnemyProjectile(float xPos, float yPos, float targetX, float targetY, int r, int g, int b) {
    location = new PVector(xPos, yPos);
    xPos = targetX;
    yPos = targetY;
    rotation = atan2(yPos - location.y, xPos - location.x) / PI * 180;
    
    red = r;
    green = g;
    blue = b;
    
    speed = 15;
  }
  
  void update() {
    location.x += cos(rotation/180*PI)*speed;
    location.y += sin(rotation/180*PI)*speed;
  }
  
  void display() {
    fill(red, green, blue);
    ellipse(location.x, location.y, 50, 50);
  }
}
