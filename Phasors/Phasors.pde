int PhasorCenterX;
int PhasorCenterY;
float Vector;
float Horizontal;
float Vertical;


// ControlIP5
import controlP5.*;
ControlP5 cp5;
String textValue = "";

void setup() {
 size(800, 800);
 frameRate(30);
  PhasorCenterX=width/2;
  PhasorCenterY=height/2;
  
  //TEXTBOX
  PFont font = createFont("arial",20);
  cp5 = new ControlP5(this);
  textFont(font);
  
  cp5.addTextfield("Magnitude")
     .setPosition(10,700)
     .setSize(40,18)
     .setAutoClear(false)
     ;
   cp5.addTextfield("Angle")
     .setPosition(60,700)
     .setSize(40,18)
     .setAutoClear(false)
     ;  
   cp5.addBang("Post")
     .setPosition(110,700)
     .setSize(70,18)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;   
     
}

void draw() {
  //clear screen
  redraw();
  background(200);
  
  //future use?
  scale(1.0);
  
  //Text
  fill(255,2,222);
  textSize(18);
  text("Mouse X :", 10, 30);text(mouseX-width/2, 100, 30);
  text("Mouse Y :", 10, 50);text(((mouseY-height/2)*-1), 100, 50);
  float h = sqrt(sq(mouseX-width/2)+sq(((mouseY-height/2)*-1)));
  text("H            :", 10, 70);text(h, 100, 70);
  
  //circle
  fill(200);
  stroke(0, 0, 0);
  strokeWeight(2);
  circle(PhasorCenterX,PhasorCenterY,600);
   
  //cross hairs
  strokeWeight(1);
  line(PhasorCenterX,PhasorCenterY,PhasorCenterX,150);//Y+
  line(PhasorCenterX,PhasorCenterY,PhasorCenterX,650);//Y-
  line(PhasorCenterX,PhasorCenterY,650,PhasorCenterY);//X+
  line(PhasorCenterX,PhasorCenterY,150,PhasorCenterY);//X-
  
  /*Tracer Lines
    stroke(0, 128, 0);
    strokeWeight(3);
    //x
    float mx = constrain(mouseX, 150, 650);
    line(mx,PhasorCenterY,mx,mouseY);
    //y
    stroke(0, 0, 128);
    float my = constrain(mouseY, 150, 650);
    line(PhasorCenterX,my,mouseX,my);
    stroke(255, 0, 0);
    strokeWeight(2);
    arrow(PhasorCenterX,PhasorCenterY,mouseX,mouseY,5);
  
  */
  //testing
    //mouse lables
    //text(mouseX-400, mouseX+10, mouseY-15);
    //text((mouseY-400)*-1, mouseX-40, mouseY+30);
    
  //Pythag(3.26,4);
  //Draw Vectors !!!
  DrawVector(0,120,"VAN",255,0,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  DrawVector(240,120,"VBN",0,0,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  DrawVector(120,120,"VCN",0,0,255);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  DrawVector(0+30,208,"VAB",0,128,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);// NOTE Line Current Laggs Phase Current By 30degrees
  DrawVector(240+30,208,"VBC",0,128,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  DrawVector(120+30,208,"VCA",0,128,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  
  
  
  

  //text(cp5.get(Textfield.class,"Magnitude").getText(), 10,750);
  
  //println(nf((208/sqrt(3)),0));//120V
}


void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()
            +"': "
            +theEvent.getStringValue()
            );
  }
}

public void Post() {
  DrawVector(0,12,"IA",128,0,0);//DrawVector(Degrees,Magnitude,Label,R,G,B);
  
  //cp5.get(Textfield.class,"Magnitude").clear();
}

public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

void Pythag(float a,float b){
//println(a,b);
Vector = sqrt(sq(a)+sq(b));
println(Vector);
}

void DrawVector(int i,float v,String Label,int R, int G, int B){
Horizontal = v*cos(radians(i));
Vertical = v*sin(radians(i));
//println(Horizontal + ", " + Vertical);// Debugging Only
arrow(PhasorCenterX,PhasorCenterY,PhasorCenterX-(Horizontal)*-1,PhasorCenterY+(Vertical)*-1,5,R,G,B);
fill(0);text(Label + " = " + v + " V @ " + i, PhasorCenterX-(Horizontal+15)*-1, PhasorCenterY+(Vertical-20)*-1);
}

void arrow(float x1, float y1, float x2, float y2, int s1,int R, int G, int B) {
  
  stroke(R, G, B);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -s1, -s1);
  line(0, 0, s1, -s1);
  popMatrix();
} 
