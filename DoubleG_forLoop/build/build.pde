import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;
boolean record = false;

HShape d;
HColorPool colors;
long seed;

void setup() {
	size(600, 600);
	H.init(this).background(#FFBC36);
	smooth();
  seed = (long)random(100000);
  randomSeed(seed);
  println("Seed:" + seed);

	colors = new HColorPool(#0c0c04, #5c9c04, #418006, #e21c04, #2e4e3c, #346304, #7f942a, #626d4d, #314b09, #9c5424).fillOnly();

	for (int i = 0; i < 5; ++i) {
		d = new HShape("COWSVG.svg");
		d
			.enableStyle(false)
			.strokeWeight(5)
			.stroke(#111111)
			.fill(#111111,200)
			.scale(random(0.5,1))
			//.size( (int)random(200,400) )
			.rotate((int)random(360))
			.loc( (int)random(-300,width), (int)random(-300,height) )
			.anchorAt(H.CENTER)
		;
		d.randomColors(colors.fillOnly());
		H.add(d);
	}

}

void draw() {	
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "/render/render-######_"+seed+".pdf");
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

void mousePressed() {
    record = true;
}
