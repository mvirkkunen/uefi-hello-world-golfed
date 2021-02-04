mkdir -p image/efi/boot
rm -f image/efi/boot/bootx64.efi

nasm -f bin -o image/efi/boot/bootx64.efi efi64.asm
#echo "bootx64.efi" > image/efi/boot/startup.nsh

qemu-system-x86_64 -bios OVMF.fd -hda fat:rw:image
