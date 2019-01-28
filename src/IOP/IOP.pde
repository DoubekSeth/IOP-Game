//Hero Stuff
Hero hero;
int canBeDamaged;
boolean canFire;

//Inputs
boolean[] keys;

//Projectiles
ArrayList<Projectile> projectiles;

//Bosses
boolean[] bossesActive;
Boss[] bosses;
Boss GorgoneshTheForeshadower;
Boss VirvaltTheSyntactical;
Boss YsceraTheFateweaver;
Boss Sans;

int bossCounter;

ArrayList<EnemyProjectile> enemyProjectiles;

//"Emotes"
ArrayList<String> emotes;
ArrayList<Boolean> hasDoneEmote;
boolean emote;
PFont font;

void setup() {
  //Bosses
  bossCounter = 0;
  enemyProjectiles = new ArrayList<EnemyProjectile>();

  bossesActive = new boolean[4];
  bosses = new Boss[4];

  VirvaltTheSyntactical = new Boss(25, 400, 150, 150, 255, 0, 255, false);
  bosses[0] = VirvaltTheSyntactical;
  GorgoneshTheForeshadower = new Boss(17, 300, 100, 100, 250, 0, 250, false);
  bosses[1] = GorgoneshTheForeshadower;
  YsceraTheFateweaver = new Boss(3, 500, 100, 100, 0, 250, 0, false);
  bosses[2] = YsceraTheFateweaver;
  Sans = new Boss(15, 500, 100, 100, 0, 0, 255, true);
  bosses[3] = Sans;

  //Emotes
  emotes = new ArrayList<String>();
  hasDoneEmote = new ArrayList<Boolean>();
  emote = false;
  fill(0, 0, 0);

  font = createFont("DTM-Sans.otf", 32);
  textSize(32);
  textAlign(CENTER, CENTER);
  emotes.add("Solve this one buddy: \n" + "My Lifelong Involvement with Mrs. Dempster began... (Page 1) \n \nBecause of the way he died... (Page 251)");
  emotes.add("How about this one: \n" + "My backside was immense and wobbled when I walked. (Page 2)\n\n" + "...it was there, in that box, that I had my seizure... (Page 252)");
  emotes.add("Here is my final question: \n" + "My lifelong involement with Mrs. Dempster began at\n 5:58 o'clock p.m. on 27 December 1908. (Page 1)\n\n" + "And that, Headmaster, is all I have to tell you. (page 252)");

  emotes.add("Look at this riddle child: \n\n" + "...when Percy was humiliated he was vindictive. (page 1)");
  emotes.add("Your mind is weak, solve this and live: \n\n" + "In such snow his sled with its tall runners and foolish steering\n apparatus was clumsy and apt to stick, whereas my low-slung\n old affair would almost have slid on grass without snow. (page 1)");
  emotes.add("One final question before I go: \n\n" + "The police had to make it clear that they really could not investigate\n impapable offences, however annyoing they might be. (page 252)");

  emotes.add("I see that you traveled far, explain this to me wise one: \n\n" + "Could The Five have changed in the story, or were they cemented in place?");
  emotes.add("Ahh, you've been doing well so far, but let's see how this treats your: \n\n" + "Davies' uses the time a lot in his book, explain why?");
  emotes.add("I was no match for you, here is my parting gift: \n\n" + "Was Dunny's fate set after the snowball had been thrown?");

  emotes.add("You have awoken me, puny human, to even have \n the slightest survival chance you must answer this question: \n\n" + "How Does this relate to the MOWAH");
  emotes.add("Good Job Answering the MOWAH, You have done well \n Made by: Seth Doubek");
  emotes.add("");

  for (int i = 0; i < emotes.size(); i++) {
    hasDoneEmote.add(false);
  }

  //Upkeep
  fullScreen();
  background(175, 175, 175);

  //Hero
  rectMode(CENTER);
  hero = new Hero();
  keys = new boolean[5];
  canBeDamaged = 0;
  canFire = true;

  //Inputs
  keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;
  keys[4] = false;


  //Projectiles
  projectiles = new ArrayList<Projectile>();
}

void draw() {
  canBeDamaged--;

  //All the stuff for block logic
  detectBlock();
  background(175, 175, 175);


  //Stuff about the player
  hero.display();
  hero.checkEnemy();

  //Boss Updater
  if (!emote) {
    bossUpkeep();
  }


  //Key Inputs
  keyPress();

  //Stuff about the projectiles
  updateProjectiles();
  mouseChecker();

  if (emote) {
    doEmote();
  }
}


//Detects when the player hits the edge
void detectBlock() {
  if (hero.x > width-18) {
    hero.x = width-18;
  } else if (hero.x < 18) {
    hero.x = 18;
  } else if (hero.y > height-18) {
    hero.y = height-18;
  } else if (hero.y < 18) {
    hero.y = 18;
  }
}

//Updates the projectiles
void updateProjectiles() {
  for (int i = projectiles.size()-1; i >= 0; i--) {
    Projectile projectile = projectiles.get(i);
    projectile.update();
    projectile.display();
    if (!(projectile.location.x > 0 && projectile.location.x < width && projectile.location.y > 0 && projectile.location.y < height)) {
      projectiles.remove(i);
    }
  }

  for (int i = enemyProjectiles.size()-1; i >= 0; i--) {
    EnemyProjectile projectile = enemyProjectiles.get(i);
    projectile.update();
    projectile.display();
    if (!(projectile.location.x > 0 && projectile.location.x < width && projectile.location.y > 0 && projectile.location.y < height)) {
      enemyProjectiles.remove(i);
    }
  }
}

//Projectiles when mouse pressed
int count = 0;
void mouseChecker() {
  if (mousePressed == true) {
    if (mouseButton == LEFT) {
      count++;
      if (count % 7 == 0 && canFire) {
        projectiles.add(new Projectile());
      }
    }
  }
}

//Update the bosses
boolean win = false;
boolean finalStage = false;
int winCounter = 0;
void bossUpkeep() {
  emote();
  if (bossesActive[1]) {
    bossCounter++;
    GorgoneshTheForeshadower.checkProjectiles();
    chargeThem();
    GorgoneshTheForeshadower.display();
    GorgoneshTheForeshadower.displayHealth();
    textSize(24);
    text("Virvalt, The Syntactical", width/2, 45);
    textSize(32);
    if (GorgoneshTheForeshadower.health <= 0) {
      bossesActive[1] = false;
      bossCounter = 0;
      hero.health = 4;
    }
  } else if (bossesActive[0]) {
    bossCounter++;
    VirvaltTheSyntactical.checkProjectiles();
    doProjectiles();
    VirvaltTheSyntactical.display();
    VirvaltTheSyntactical.displayHealth();
    textSize(24);
    text("Gorgonesh, The Foreshadower", width/2, 45);
    textSize(32);
    if (VirvaltTheSyntactical.health <= 0) {
      bossesActive[0] = false;
      bossCounter = 0;
      hero.health = 5;
    }
  } else if (bossesActive[2]) {
    bossCounter++;
    YsceraTheFateweaver.checkProjectiles();
    ysceraProjectiles();
    YsceraTheFateweaver.charge(hero.x, hero.y);
    YsceraTheFateweaver.display();
    YsceraTheFateweaver.displayHealth();
    textSize(24);
    text("Yscera, The Fateweaver", width/2, 45);
    textSize(32);
    if (YsceraTheFateweaver.health <= 0) {
      bossesActive[2] = false;
      win = true;
      bossCounter = 0;
      hero.health = 6;
    }
  } else if (win) {
    winCounter++;
    textSize(92);
    text("YOU WIN!", width/2, height/2);
    textSize(32);
    if (winCounter >= 500) {
      win = false;
      finalStage = true;
      winCounter = -50;
    }
  } else if (finalStage) {
    winCounter++;
    textFont(font);
    textSize(92);
    text("Hahaha....\n You thought it would\n really be this easy?", width/3, height/2);
    if (winCounter >= 0 && winCounter <= 510) {
      fill(0, 0, winCounter/2);
      ellipse(3*width/4, height/2, 150, 150);
      fill(255-winCounter/2);
      ellipse(3*width/4, height/2, 50, 50);
    } else if (winCounter > 511) {
      bossesActive[3] = true;
      finalStage = false;
    }
  } else if (bossesActive[3]) {
    bossCounter++;
    Sans.checkProjectiles();
    chargeThem();
    doProjectiles();
    Sans.display();
    Sans.displayHealth();
    textSize(24);
    text("SANS, THE MOWAH MONSTER", width/2, 45);
    textSize(32);
    if (Sans.health <= 0) {
      bossesActive[3] = false;
      bossCounter = 0;
    }
  }
}

void doProjectiles() {
  if (bossCounter >= 150) {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true && bosses[i] == VirvaltTheSyntactical) {
        bosses[i].blue = 0;
        bosses[i].red = 0;
        bosses[i].barrage();
        bossCounter = 0;
      }
    }
  } else {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].blue += 1.7;
        bosses[i].red += 1.7;
      }
    }
  }
  if (bossCounter % 75 == 0) {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].spamEzMode();
      }
    }
  } else if (bossCounter % 50 == 0) {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].spamAxis();
      }
    }
  } else if (bossCounter % 25 == 0) {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].spamDiagonal();
      }
    }
  }
}

void ysceraProjectiles() {
  if (bossesActive[2]) {
    if (bossCounter % 25 == 0) {
      YsceraTheFateweaver.tShot();
    } else if (bossCounter >= 50) {
      YsceraTheFateweaver.green = 0;
      bossCounter = 0;
    } else {
      YsceraTheFateweaver.green += 5;
    }
  }
}

void chargeThem() {
  int targetX = hero.x;
  int targetY = hero.y;
  if (bossCounter >= 250) {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].red -= 1.93;
        if (bossCounter == 380) {
          bossCounter = 0;
        }
        bosses[i].charge(targetX, targetY);
      }
    }
  } else {
    for (int i = 0; i < bosses.length; i++) {
      if (bossesActive[i] == true) {
        bosses[i].red++;
      }
    }
  }
}




//Emotes
void emote() {
  if (bossesActive[1] == true) {
    if (float(bosses[1].health)/float(bosses[1].potentialHealth) < 2.0/3.0 && !hasDoneEmote.get(0)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[1].health)/float(bosses[1].potentialHealth) < 1.0/3.0 && !hasDoneEmote.get(1)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[1].health) == 1 && !hasDoneEmote.get(2)) {
      emote = true;
      draw();
      noLoop();
    }
  } else if (bossesActive[0] == true) {
    if (float(bosses[0].health)/float(bosses[0].potentialHealth) < 2.0/3.0 && !hasDoneEmote.get(3)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[0].health)/float(bosses[0].potentialHealth) < 1.0/3.0 && !hasDoneEmote.get(4)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[0].health) == 1 && !hasDoneEmote.get(5)) {
      emote = true;
      draw();
      noLoop();
    }
  } else if (bossesActive[2] == true) {
    if (float(bosses[2].health)/float(bosses[2].potentialHealth) < 2.0/3.0 && !hasDoneEmote.get(6)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[2].health)/float(bosses[2].potentialHealth) < 1.0/3.0 && !hasDoneEmote.get(7)) {
      emote = true;
      draw();
      noLoop();
    } else if (float(bosses[2].health) == 1 && !hasDoneEmote.get(8)) {
      emote = true;
      draw();
      noLoop();
    }
  } else if (bossesActive[3] == true) {
    if (!hasDoneEmote.get(9)) {
      emote = true;
      draw();
      noLoop();
    } else if (bosses[3].health == 1 && !hasDoneEmote.get(10)) {
      emote = true;
      draw();
      noLoop();
    }
  }
}

int emoteCounter;
void doEmote() {
  fill(150);
  rect(width/2, height/2, 1300, 800);
  fill(0);
  text(emotes.get(emoteCounter), width/2, height/2);
}

//KEYS!
//The thing doing the heavy lifting
void keyPress() {
  if (keys[0] == true) {
    hero.moveUp();
  }
  if (keys[1] == true) {
    hero.moveDown();
  }
  if (keys[2] == true) {
    hero.moveLeft();
  }
  if (keys[3] == true) {
    hero.moveRight();
  }
  if (keys[4] == true) {
    hero.speed = 15;
  } else {
    hero.speed = 5;
  }
}

//When they type something
void keyPressed() {
  if (key == 'w') {
    keys[0] = true;
  }
  if (key == 's') {
    keys[1] = true;
  }
  if (key == 'a') {
    keys[2] = true;
  }
  if (key == 'd') {
    keys[3] = true;
  }
  if (key == 'o') {
    bossesActive[0] = true;
  }
  if (key == 'p') {
    bossesActive[1] = true;
  }
  if (key == 'i') {
    bossesActive[2] = true;
  }
  if (key == ' ') {
    keys[4] = true;
    canFire = false;
  }
  if (key == 'n') {
    emote = false;
    loop();
    hasDoneEmote.set(emoteCounter, true);
    emoteCounter++;
    canBeDamaged = 50;
  }
  if (key == 'u') {
    win = true;
  }
}

//When they release something
void keyReleased() {
  if (key == 'w') {
    keys[0] = false;
  }
  if (key == 's') {
    keys[1] = false;
  }
  if (key == 'a') {
    keys[2] = false;
  }
  if (key == 'd') {
    keys[3] = false;
  }
  if (key == ' ') {
    keys[4] = false; 
    canFire = true;
  }
}
