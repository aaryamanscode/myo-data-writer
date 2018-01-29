import de.voidplus.myo.*;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;

Myo myo;
PrintWriter orientationWrite;
PrintWriter gyroWrite;
PrintWriter emgWrite;

void setup() {
  size(1000, 1000);
  myo = new Myo(this);
  orientationWrite = createWriter("orientation.txt"); 
  gyroWrite = createWriter("gyro.txt");
  emgWrite = createWriter("emg.txt");
}


void draw() {
  //Set Background
  background(0);  
  
  //Read Data
  PVector pvg = myo.getGyroscope();
  int[] emg = myo.getEmg();
  PVector pvo = myo.getOrientation();
  
  //Write to file
  orientationWrite.println(pvo.x + ", " + pvo.y + ", " + pvo.z);
  gyroWrite.println(pvg.x + ", " + pvg.y + ", " + pvg.z);
  for(int i = 0; i < emg.length; i++) {
    emgWrite.print(emg[i] + ", ");
  }
  emgWrite.println();
  
  
  text("ORIENTATION", 0, 20);
  text(pvo.x, 0, 60);
  text(pvo.y, 0, 100);
  text(pvo.z, 0, 140);
  
  text("GYROSCOPE", 0, 180);
  text(pvg.x, 0, 200);
  text(pvg.y, 0, 240);
  text(pvg.z, 0, 280);
  
  text("EMG", 0, 320);
  int helper = 340;
  for(int i = 0; i < emg.length; i++) {
    text(emg[i], 0, helper);
    helper += 40;
  }
}

void keyPressed() {
  
  if(key == 's') {
    if(myo.hasDevices()) {
      myo.vibrate();
      myo.requestRssi();
      myo.requestBatteryLevel();
      myo.setLockingPolicy(Myo.LockingPolicy.NONE);
      myo.withEmg();
    }
  }
  
  if(key == 'x') {
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    exit(); // Stops the program
  }
}