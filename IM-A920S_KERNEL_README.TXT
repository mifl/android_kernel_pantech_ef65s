How to Build:

    1. Get Toolchain (arm-eabi-4.6) and install
       (Visit android git server or codesourcery)

    2. Build the Kernel:
        1) Modify below lines in "build_kernel.sh"
            export PATH=$(pwd)/../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
        2) Run Kernel Build Script
            $ ./build_kernel.sh

    3. Output Files:
        - kernel : kernel/zImaze
        - module : kernel/drivers/*/*.ko

    4. Clean Kernel:
        1) Modify below lines in "clean_kernel.sh"
            export PATH=$(pwd)/../../../prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin:$PATH
        2) Run Kernel Clean Script
            $ ./clean_kernel.sh
