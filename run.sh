mkdir -p image/efi/boot
rm -f image/efi/boot/boot64.efi

fasm efi64.asm image/efi/boot/boot64.efi
echo "boot64.efi" > image/efi/boot/startup.nsh

qemu-system-x86_64 -bios OVMF.fd -hda fat:rw:image
