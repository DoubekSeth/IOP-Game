class Boss {
  int health;
  int potentialHealth;
  PVector location;
  int bossHeight;
  int bossWidth;
  int speed;

  int red;
  int green;
  int blue;
  
  int redConstant;
  int greenConstant;
  int blueConstant;
  
  int canBeHarmed;
  
  boolean sans;
  
  Boss(int speed, int health, int bossTall, int bossLong, int r, int g, int b, boolean sans) {
    location = new PVector(width/2, height/2);
    this.speed = speed;
    this.health = health;
    potentialHealth = health;
    canBeHarmed = 200;
    canBeDamaged = 200;
    
    bossHeight = bossTall;
    bossWidth = bossLong;
    
    redConstant = r;
    greenConstant = g;
    blueConstant = b;
    
    this.sans = sans;
  }

  void checkProjectiles() {
    canBeHarmed--;
    for (int i = projectiles.size()-1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      if (projectile.location.x > location.x - bossWidth/2 && projectile.location.x < location.x + bossWidth/2 && projectile.location.y > location.y - bossHeight/2 && projectile.location.y < location.y + bossHeight/2 && canBeHarmed <= 0) {
        health -= 1;
        projectiles.remove(i);
        displayHealth();
      }
    }
  }

  void displayHealth() {
    fill(228, 10, 245);
    rectMode(CORNER);
    rect(width/4, 10, width/2, 10);
    fill(0, 0, 0);
    quad(3*width/4, 10, 3*width/4, 20, (float(health)/float(potentialHealth)) * (3*width/4) + (width/4 * (1-(float(health)/float(potentialHealth)))), 20, (float(health)/float(potentialHealth)) * (3*width/4) + (width/4 * (1-(float(health)/float(potentialHealth)))), 10);
    
    rectMode(CENTER);
  }

  void display() {
    if(sans) {
      fill(0, 0, 255);
      ellipse(location.x, location.y, 150, 150);
      fill(0, 0, 0);
      ellipse(location.x, location.y, 50, 50);
    } else {
      fill(red, green, blue);
      ellipse(location.x, location.y, bossHeight, bossWidth);
    }
  }

  void charge(int targetX, int targetY) {
    float rotation = atan2( targetY - location.y, targetX - location.x) / PI * 180;
    location.x += cos(rotation/180*PI)*speed;
    location.y += sin(rotation/180*PI)*speed;
  }
  
  void barrage(){
    for(int i = 0; i < 5; i++) {
      enemyProjectiles.add(new EnemyProjectile(location.x - 150 + i*60, location.y - 150 + i*60, redConstant, greenConstant, blueConstant));
    }
  }
  
  
  void spamAxis(){
   enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width/2, 0, redConstant, greenConstant, blueConstant));
   enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width/2, height, redConstant, greenConstant, blueConstant)); 
   enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 0, height/2, redConstant, greenConstant, blueConstant)); 
   enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width, height/2, redConstant, greenConstant, blueConstant));
  }
  
  void spamDiagonal(){
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 0, 0, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width, 0, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width, height, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 0, height, redConstant, greenConstant, blueConstant));
  }
  
  void spamEzMode(){
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width/3, 0, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 2*width/3, 0, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 2*width/3, height, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width/3, height, redConstant, greenConstant, blueConstant));
  }
  
  void tShot() {
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, location.x, 0, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, location.x, height, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, 0, location.y, redConstant, greenConstant, blueConstant));
    enemyProjectiles.add(new EnemyProjectile(location.x, location.y, width, location.y, redConstant, greenConstant, blueConstant));
  }
}
