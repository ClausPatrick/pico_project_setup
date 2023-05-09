#!/bin/sh


echo "Directory name: $1, Project name: $2"
mkdir $1
cd $1
touch main.cpp
touch CMakeLists.txt
touch build_script.sh
touch build_debug_script.sh
echo "#!/bin/sh" >> build_script.sh
echo "rm -rf build" >> ../build_script.sh
echo "mkdir build" >> build_script.sh
echo "cd build" >> build_script.sh
echo "export PICO_SDK_PATH=../../pico-sdk" >> build_script.sh
echo "cmake .." >> build_script.sh
chmod +x build_script.sh


echo "#!/bin/sh" >> build_debug_script.sh
echo "rm -rf build" >> build_debug_script.sh
echo "mkdir build" >> build_debug_script.sh
echo "cd build" >> build_debug_script.sh
echo "export PICO_SDK_PATH=../../pico-sdk" >> build_debug_script.sh
echo "cmake -DCMAKE_BUILD_TYPE=Debug .." >> build_debug_script.sh
echo "make -j4" >> build_debug_script.sh
chmod +x build_debug_script.sh

echo "echo \"|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|\"" >> build_debug_script.sh
echo "echo \"|Open new terminal and let it run in the background after:          |\"" >> build_debug_script.sh
echo "echo \"|openocd -f interface/raspberrypi-swd.cfg -f target/rp2040.cfg      |\"" >> build_debug_script.sh
echo "echo \"|Then run this from within the build folder:                        |\"" >> build_debug_script.sh
echo "echo \"|gdb-multiarch filename.elf                                         |\"" >> build_debug_script.sh
echo "echo \"|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|\"" >> build_debug_script.sh


mkdir u2u
cp ~/redshare/code/swap_files/u2u/u2u.h u2u/.
cp ~/redshare/code/swap_files/u2u/u2u.c u2u/.
cp ~/redshare/code/swap_files/u2u/u2uclientdef.h u2u/.
cp ~/redshare/code/swap_files/u2u/CMakeLists.txt u2u/.
#include ,


cp  ~/pico/pico-sdk/external/pico_sdk_import.cmake .
mkdir build
cd build

echo "cmake_minimum_required(VERSION 3.13)" >> ../CMakeLists.txt
echo "include(pico_sdk_import.cmake)" >> ../CMakeLists.txt
echo "project($2 C CXX ASM)" >> ../CMakeLists.txt
echo "set(CMAKE_C_STANDARD 11)" >> ../CMakeLists.txt
echo "set(CMAKE_CXX_STANDARD 17)" >> ../CMakeLists.txt
#echo "set(PICO_EXAMPLES_PATH ${PROJECT_SOURCE_DIR})" >> ../CMakeLists.txt
echo "pico_sdk_init()" >> ../CMakeLists.txt
echo "add_subdirectory(u2u)" >> ../CMakeLists.txt
echo "add_executable($2 main.cpp)" >> ../CMakeLists.txt
#echo "target_link_libraries($2  pico_stdlib hardware_dma hardware_i2c)" >> ../CMakeLists.txt
echo "target_link_libraries($2  pico_stdlib hardware_uart hardware_dma hardware_i2c hardware_timer hardware_spi hardware_pwm pico_multicore u2u sgp40)" >> ../CMakeLists.txt

echo "pico_enable_stdio_usb($2 1)" >> ../CMakeLists.txt
echo "pico_enable_stdio_uart($2 0)" >> ../CMakeLists.txt
echo "pico_add_extra_outputs($2)" >> ../CMakeLists.txt



#echo "#include <stdio.h>" >> ../main.cpp
#echo "#include \"pico/stdlib.h\"" >> ../main.cpp
#echo "#include \"hardware/uart.h\"" >> ../main.cpp
#echo "#include \"hardware/dma.h\"" >> ../main.cpp
#echo "#include \"hardware/irq.h\"" >> ../main.cpp
#echo "#include \"hardware/i2c.h\"" >> ../main.cpp

echo "#include <stdio.h>" >> ../main.cpp
echo "#include <string>" >> ../main.cpp
echo "#include \"pico/stdlib.h\"" >> ../main.cpp
echo "#include \"hardware/uart.h\"" >> ../main.cpp
echo "#include \"hardware/dma.h\"" >> ../main.cpp
echo "#include \"hardware/irq.h\"" >> ../main.cpp
echo "#include \"hardware/i2c.h\"" >> ../main.cpp
echo "#include \"hardware/spi.h\"" >> ../main.cpp
echo "#include \"hardware/pwm.h\"" >> ../main.cpp
echo "#include \"pico/multicore.h\"" >> ../main.cpp


echo "extern /"C/" {" >> ../main.cpp
echo "    #include /"u2u.c/"" >> ../main.cpp
echo "}" >> ../main.cpp

echo "#define LED_ONBOARD 25" >> ../main.cpp



echo "" >> ../main.cpp
echo "#define output_nr 1" >> ../main.cpp
echo "" >> ../main.cpp
echo "const uint8_t outputpins[] = {LED_ONBOARD};" >> ../main.cpp
echo "bool timer_callback(repeating_timer_t *rt);" >> ../main.cpp
echo "static bool tog_led = 0;" >> ../main.cpp
echo "" >> ../main.cpp
echo "void io_setup(){" >> ../main.cpp

echo "" >> ../main.cpp
echo "    for (int c=0; c<output_nr; c++)" >> ../main.cpp
echo "    {" >> ../main.cpp
echo "            gpio_init(outputpins[c]);" >> ../main.cpp
echo "            gpio_set_dir(outputpins[c], GPIO_OUT);" >> ../main.cpp
echo "            gpio_put(outputpins[c], 0);" >> ../main.cpp
echo "    }" >> ../main.cpp
echo "    i2c_init(i2c0, 100 * 1000);" >> ../main.cpp
echo "    //gpio_set_function(SDA_PIN, GPIO_FUNC_I2C);" >> ../main.cpp
echo "    //gpio_set_function(SCL_PIN, GPIO_FUNC_I2C);" >> ../main.cpp
echo "    //gpio_pull_up(SDA_PIN); // Pull ups are 4K7 added externally." >> ../main.cpp
echo "    //gpio_pull_up(SCL_PIN);" >> ../main.cpp
echo "}" >> ../main.cpp
echo "" >> ../main.cpp
echo "" >> ../main.cpp

echo "void core(){" >> ../main.cpp
echo "    int i;" >> ../main.cpp
echo "    busy_wait_us(10000);" >> ../main.cpp
echo "    while (1){" >> ../main.cpp
echo "        busy_wait_us(1000);" >> ../main.cpp
echo "    }" >> ../main.cpp
echo "}" >> ../main.cpp



echo "int main(){" >> ../main.cpp
echo "    stdio_usb_init();" >> ../main.cpp
echo "    busy_wait_us(1000)" >> ../main.cpp
echo "    io_setup();" >> ../main.cpp
echo "    message_setup()" >> ../main.cpp
echo "    busy_wait_us(1000)" >> ../main.cpp
echo "    repeating_timer_t timer;" >> ../main.cpp
echo "    add_repeating_timer_ms(200, timer_callback, NULL, &timer);" >> ../main.cpp
echo "    busy_wait_us(1000)" >> ../main.cpp
echo "    multicore_launch_core1(core1);" >> ../main.cpp
echo "    while (1){" >> ../main.cpp
echo "        if (message_ready==1){" >> ../main.cpp
echo "            inbound_message = message_processor();" >> ../main.cpp
echo "        }" >> ../main.cpp
echo "    }" >> ../main.cpp
echo "" >> ../main.cpp
echo "}" >> ../main.cpp
echo "" >> ../main.cpp

echo "" >> ../main.cpp
echo "bool timer_callback(repeating_timer_t *rt){" >> ../main.cpp
echo "     tog_led = 1-tog_led;" >> ../main.cpp
echo "     gpio_put(LED_PIN, tog_led);" >> ../main.cpp
echo "     return true;" >> ../main.cpp
echo "}" >> ../main.cpp


export PICO_SDK_PATH=~/pico/pico-sdk
cmake ..
