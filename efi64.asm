format pe64 dll efi
entry efi_main

section '.text' code executable readable
efi_main:
    mov rcx, rdx
    mov rcx, [rcx + 0x40] ; ConOut
    lea rdx, [Message]
    call qword [rcx + 0x08] ; OutputString

    mov eax, 0 ; EFI_SUCCESS
    retn

section '.rodata' data readable
    Message du "Hello EFI World!", 0x0D, 0x0A
            du 0x00
