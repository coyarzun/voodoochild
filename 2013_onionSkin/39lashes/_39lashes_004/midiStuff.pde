void noteOn(Note note){
  try{
  int vel = note.getVelocity();
  int pit = note.getPitch();
  println(pit+" "+vel);
  if(vel!=64)drums.sendNote(new Note(pit, vel, 2));
  }catch(Exception e){
  }
}

void noteOff(Note note){
  try{
  int pit = note.getPitch();
  drums.sendNote(new Note(pit, 0, 0));
  }catch(Exception e){
  }
}

void controllerIn(Controller controller){
  try{
  
    int num = controller.getNumber();
    int val = controller.getValue();
    drums.sendController(new Controller(num, val));
  }catch(Exception e){
  }
}

void programChange(ProgramChange programChange){
  int num = programChange.getNumber();
}
