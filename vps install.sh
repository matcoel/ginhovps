#!/bin/bash
 
echo -e "\033[31mEscolha seu sistema operacional VM"
echo -e "\033[32m1\033[0m) \033[0; 33mXubuntu 24.04\033[0m"
echo -e "\033[32m2\033[0m) \033[0; 33mKubuntu 24.04\033[0m"
echo -e "\033[32m3\033[0m) \033[0; 33mLubuntu 24.04\033[0m"
echo -e "\033[32m4\033[0m) \033[0; 33mUbuntu 24.04\033[0m"
echo -e "\033[32m5\033[0m) \033[0; 33mWindows 10 LTSC\033[0m"
echo -e "\033[32m6\033[0m) \033[0; 33mWindows 11 LTSC\033[0m"
echo -e "\033[32m7\033[0m) \033[0; 33mTiny11\033[0m"
read -p 'Número do sistema operacional: ' num
se [ $num == 1 ] ; então
    url="https://nl.archive.ubuntu.com/ubuntu-cdimage-xubuntu/releases/24.04/release/xubuntu-24.04-desktop-amd64.iso"
elif [ $num == 2 ] ; então
    url="https://cdimage.ubuntu.com/kubuntu/releases/24.04/release/kubuntu-24.04-desktop-amd64.iso"
elif [ $num == 3 ] ; então
    url="https://cdimage.ubuntu.com/lubuntu/releases/24.04/release/lubuntu-24.04-desktop-amd64.iso"
elif [ $num == 4 ] ; então
    url="https://releases.ubuntu.com/noble/ubuntu-24.04-desktop-amd64.iso"
elif [ $num == 5 ] ; então
    url="https://go.microsoft.com/fwlink/p/?LinkID=2195404&clcid=0x409&culture=en-us&country=US"
elif [ $num == 6 ] ; então
    url="https://archive.org/download/26100-ltsc-x64-enus/26100.1.240331-1435.ge_release_CLIENT_ENTERPRISES_OEM_x64FRE_en-us.iso"
elif [ $num == 7 ]; então
    url="https://archive.org/download/tiny11-2311/tiny11%202311%20x64.iso"
mais
    echo 'Número inválido.'
    sair
Fi
read -p 'Núcleos a serem usados na VM: ' núcleos
read -p 'RAM para usar na VM (ex: 4G): ' ram
read -p 'Tamanho do disco da VM: ' disco
atualização do sudo apt
sudo apt install qemu-kvm git wget -y
wget -O vm.iso $url
qemu-img criar -f vm.img bruto $disk
git clone https:github.com/novnc/noVNC.git
gato <<EOF > vm.sh
sudo qemu-system-x86_64 -m $ram -smp $cores -cpu 'Skylake-Client,kvm=off,-hypervisor' -boot order=c -drive file=vm.iso,media=cdrom -drive file=vm.img,format=raw -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device e1000,netdev=n0 -device usb-tablet -vnc :0 -smp cores=$cores $devices -netdev user,id=n0 -vga qxl -accel kvm &
. /noVNC/utils/novnc_proxy
EOF
chmod +x vm.sh
claro
echo -e '\033[0; 33mPara iniciar a VM \033[0; 32mrun \033[0; 31mvm.sh\033[0m'
