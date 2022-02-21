# retro-x86-fire

![Screenshot](https://user-images.githubusercontent.com/30597915/155018655-c37e1d18-d7a9-4f4f-8bc9-06963c5c13e9.png)

My old code from 1998.  
Displays animated fire on VGA 320x200 256-Color Mode.  
Target was smallest binary size, so I can build custom (and still fully functional) MBR with builtin fireplace simulator.  

**Tools needed:**
- NASM - https://nasm.us/
- Doxbox - https://www.dosbox.com/

**Rebuild:**
- `nasm -f bin -o fire.com fire.asm`

**Run:**
- `dosbox fire.com`

Exit by pressing Escape.
