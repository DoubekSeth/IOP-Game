class Projectile { //<>//
  PVector location;
  float xPos;
  float yPos;
  float rotation;
  float speed;

  Projectile() {
    location = new PVector(hero.x, hero.y);
    xPos = mouseX;
    yPos = mouseY;
    rotation = atan2(yPos - location.y, xPos - location.x) / PI * 180;

    speed = 20;
  }


  void update() {
    location.x += cos(rotation/180*PI)*speed;
    location.y += sin(rotation/180*PI)*speed;
  }

  void display() {
    ellipse(location.x, location.y, 10, 10);
  }
}
