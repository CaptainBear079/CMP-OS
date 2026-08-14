# Introduction
Chaotic Much Protected (short CMP) is a open-source project focusing on privacy and user customization.

It's also the main project and management point of the Chaos Code Project (view the section "Chaos Code Project").

### Please read the LICENSE file and installation instruction section. By downloading or any kind of copying you agree with the license, it's conditions and that you know what you are doing.

# Features
- Bootloader (in development)
- Kernel (in development)
- Central Command Line (short CCL, in development)

# Coming up
- Basic commands
- Basic file system

# Tools
The tools used for development are:
- High level programming:
  - [GCC](https://gcc.gnu.org/) - GNU Compiler Collection
  - [G++](https://gcc.gnu.org/) - GNU C++ Compiler (included in GCC)
  - [ChaosLang](https://github.com/CaptainBear079/ChaosLang/) - Our custom programming language (high level modules)
- Low level programming:
  - [Make](https://www.gnu.org/software/make/) - Build automation tool (for GCC toolchain and automated building)
  - [GCC](https://gcc.gnu.org/) - GNU Compiler Collection custom built for cross compiling
  - [G++](https://gcc.gnu.org/) - GNU C++ Compiler custom built for cross compiling (included in GCC)
  - [ChaosLang](https://github.com/CaptainBear079/ChaosLang/) - Our custom programming language (low level modules)
  - [NASM](https://www.nasm.us/) - Netwide Assembler
  - A virtual machine of your choice
  - A virtual machine with debugger (like [Bochs](https://bochs.sourceforge.io/))

# Installation instruction
If you want to build it yourself please go to the section "Building from source".

1. Download the latest release.
2. Burn the ISO image to a USB drive, SSD/HDD or DVD.
3. Plug in the installation media and restart your computer (you might need to change your boot order).
4. Follow the instructions to complete the installation.

# Building from source
### If your using Windows to build the source I recommend using WSL/WSL2.
1. Download and unpack the source code from the release page.
2. Make sure dependencies are installed and toolchain built (see Tools section and DEPENDENCIES.md).
- Command for dependencies installation: "sudo apt-get update && sudo apt-get install -y build-essential gcc g++ make wget tar gzip xz-utils bison flex texinfo libgmp-dev libmpfr-dev libmpc-dev nasm"
3. Open a terminal and navigate to the source directory (src).
4. Run make.
5. After the build process is complete, you can find the compiled binaries in the "build" directory.

# Other projects
- [ChaosLang](https://github.com/CaptainBear079/ChaosLang/) - Our custom programming language.
- [CCL](https://github.com/CaptainBear079/CCL/) - Our custom console/terminal.