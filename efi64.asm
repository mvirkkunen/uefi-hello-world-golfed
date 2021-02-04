bits 64

    db "MZ" ; Magic
    dw 0 ; Some old DOS thing (UNUSED)

    db `PE\0\0` ; PE Signature

    dw 0x8664 ; Machine (x64)
    dw 1 ; NumberOfSections
    dd 0 ; TimeDateStamp (UNUSED)
    dd 0 ; PointerToSymbolTable (UNUSED)
    dd 0 ; NumberOfSymbols (UNUSED)
    dw sections - opt_hdr ; SizeOfOptionalHeader
    dw 0x202f ; Characteristics (no relocations, runnable, no line numbers, no symbols, large address support, DLL file)

opt_hdr:
    dw 0x020b ; Magic (PE32+)
    db 0 ; MajorLinkerVersion (UNUSED)
    db 0 ; MinorLinkerVersion (UNUSED) (UNUSED)
    dd 0 ; SizeOfCode (UNUSED)
    dd 0 ; SizeOfInitializedData (UNUSED)
    dd 0 ; SizeOfUninitializedData (UNUSED)
    dd 0x1000 ; AddressOfEntryPoint
    dd 0 ; BaseOfCode (UNUSED)

    dq 0x400000 ; ImageBase
    dd 4 ; SectionAlignment; also PE header offset and end of DOS header
    dd 4 ; FileAlignment (UNUSED)
    dw 0 ; MajorOperatingSystemVersion (UNUSED)
    dw 0 ; MinorOperatingSystemVersion (UNUSED)
    dw 0 ; MajorImageVersion (UNUSED)
    dw 0 ; MinorImageVersion (UNUSED)
    dw 0 ; MajorSubsystemVersion (UNUSED)
    dw 0 ; MinorSubsystemVersion (UNUSED)
    dd 0 ; Win32VersionValue (UNUSED)
    dd 0x2000 ; SizeOfImage
    dd text ; SizeOfHeaders
    dd 0 ; CheckSum (UNUSED)
    dw 0x000a ; Subsystem (EFI_APPLICATION)
    dw 0 ; DllCharacteristics (UNUSED)
    dq 0 ; SizeOfStackReserve (UNUSED)
    dq 0 ; SizeOfStackCommit (UNUSED)
    dq 0 ; SizeOfHeapReserve (UNUSED)
    dq 0 ; SizeOfHeapCommit (UNUSED)
    dd 0 ; LoaderFlags (UNUSED)
    dd 0 ; NumberOfRvaAndSizes (UNUSED)

sections:
    dq 0 ; Name (UNUSED)
    dd end_text - text ; VirtualSize
    dd 0x1000 ; VirtualAddress
    dd end_text - text ; SizeOfRawData
    dd text ; PointerToRawData
    dd 0 ; PointerToRelocations (UNUSED)
    dd 0 ; PointerToLinenumbers (UNUSED)
    dw 0 ; NumberOfRelocations (UNUSED)
    dw 0 ; NumberOfLinenumbers (UNUSED)
    dd 0x60000020 ; Characteristics (READ | EXECUTE | CODE)

text:
    mov rcx, [rdx + 0x40] ; ConOut
    lea rdx, [rel message]
    call qword [rcx + 0x08] ; OutputString

halt:
    hlt
    jmp halt

message:
    db __utf16__(`Hello, world!\r\n\0`)

end_text:
    times (268-$+$$) db 0
