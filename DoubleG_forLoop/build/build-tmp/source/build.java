import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.behavior.*; 
import hype.extended.colorist.*; 
import hype.extended.layout.*; 
import hype.interfaces.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {







boolean record = false;

HShape d;
HColorPool colors;

public void setup() {
	
	H.init(this).background(0xffFFBC36);
	

	colors = new HColorPool(0xff0c0c04, 0xff5c9c04, 0xff418006, 0xffe21c04, 0xff2e4e3c, 0xff346304, 0xff7f942a, 0xff626d4d, 0xff314b09, 0xff9c5424).fillOnly();

	for (int i = 0; i < 5; ++i) {
		d = new HShape("COWSVG.svg");
		d
			.enableStyle(false)
			.strokeWeight(5)
			.stroke(0xff111111)
			.fill(0xff111111,200)
			.scale(random(0.5f,1))
			//.size( (int)random(200,400) )
			.rotate((int)random(360))
			.loc( (int)random(-300,width), (int)random(-300,height) )
			.anchorAt(H.CENTER)
		;
		d.randomColors(colors.fillOnly());
		H.add(d);
	}

}

public void draw() {	
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-######.pdf");
	}

	if (tmp == null) {
		H.drawStage();
	} else {
		PGraphics g = tmp;
		boolean uses3D = false;
		float alpha = 1;
		H.stage().paintAll(g, uses3D, alpha);
	}

	if (record) {
		endRecord();
		record = false;
	}	
	
}

public void mousePressed() {
    record = true;
}
  public void settings() { 	size(600, 600); 	smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
