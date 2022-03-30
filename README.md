# retro-x86-fire

![Screenshot](https://user-images.githubusercontent.com/30597915/155018655-c37e1d18-d7a9-4f4f-8bc9-06963c5c13e9.png)

My old code from 1998.  
Displays animated fire on VGA 320x200 256-Color Mode.  
Target was smallest binary size, so I can build custom (and still fully functional) MBR with builtin fireplace simulator.  
Resulting in 144 bytes executable.  
Needs 80386 CPU or later.

**Tools needed:**
- NASM - https://nasm.us/
- Doxbox - https://www.dosbox.com/
- GNU Make - https://www.gnu.org/software/make/ (optional)

**Build:**
- `nasm -f bin -o fire.com fire.asm` or just run `make`

**Run:**
- `dosbox fire.com`

Exit by pressing Escape.
