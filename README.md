# retro-x86-fire

My old code from 1998
Target was smallest binary size, so I can build custom (and still fully functional) MBR with builtin fireplace simulator.

**Tools needed:**
- NASM - https://nasm.us/
- Doxbox - https://www.dosbox.com/

**Rebuild:**
- `nasm -f bin -o fire.com fire.asm`

**Run:**
- `dosbox fire.com`

Exit by pressing Escape.
