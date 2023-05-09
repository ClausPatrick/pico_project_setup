# pico_project_setup
Bash script to setup everything needed to make c++ projects, including U2U (uart to uart) functionality.
Launched within the pico directory and passed two arguments (directory name and project name) it will create a new directory (arg $1) and sets up CMakeLists and main.cpp collect the sdk as well as folder structure for build. In addition it will also setup U2U functionality in its own directory with the required CMakeLists. Furthermore two scripts are added to recreate the build folder (build_script.sh) and replace the build folder with everything needed for debugging (build_debug_script.sh).
Ultimately it will make the build but it is not being compiled. 
External files are contained within /swap_files directory and will be copied.
The functionality of main.cpp is a basic GPIO setup as well as a timer setup. Includes are added for most hardware periphery. 
