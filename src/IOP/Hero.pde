class Hero {
  //Position
  int x = width/2;
  int y = height/2;
  int heroHeight = 25;
  int heroWidth = 25;
  int speed = 5;
  int health = 3;

  //Displays character
  void display() {
    if (canBeDamaged > 0 && canBeDamaged % 5 == 0) {
      fill(150, 150, 150);
    } else {
     fill(0, 0, 0); 
    }
    rect(x, y, 25, 25);
    //Hearts
    for (int i = 0; i < health; i++) {
      fill(255, 0, 0);
      rect(10 + i*15, 10, 10, 10);
      fill(0, 0, 0);
    }
  }

  //Movement
  void moveRight() {
    x += speed;
  }

  void moveLeft() {
    x -= speed;
  }

  void moveUp() {
    y -= speed;
  }

  void moveDown() {
    y += speed;
  }


  //Checks for enemies
  void checkEnemy() {
    for (int i = 0; i < bosses.length; i++) {
      if (bosses[i].location.x > hero.x - bosses[i].bossWidth/2 && bosses[i].location.x < hero.x + bosses[i].bossWidth/2 && bosses[i].location.y > hero.y - bosses[i].bossHeight/2 && bosses[i].location.y < hero.y + bosses[i].bossHeight/2 && canBeDamaged <= 0 && bossesActive[i]) {
        health--;
        canBeDamaged = 200;
      }
    }
    for (int i = enemyProjectiles.size()-1; i >= 0; i--) {
      EnemyProjectile projectile = enemyProjectiles.get(i);
      if (projectile.location.x > hero.x - heroWidth-3 && projectile.location.x < hero.x + heroWidth+3 && projectile.location.y > hero.y - heroHeight-3 && projectile.location.y < hero.y + heroHeight+3 && canBeDamaged <= 0) {
        health -= 1;
        canBeDamaged = 200;
        enemyProjectiles.remove(i);
      }
    }
  }
}
