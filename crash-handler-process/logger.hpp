#pragma once

#include <iostream>
#include <fstream>
#include <string>

#ifndef NDEBUG
    const bool log_output_disabled = false;
#else
    const bool log_output_disabled = true;
#endif

const std::string getTimeStamp();
extern std::ofstream log_output_file;

#define log_info if (log_output_disabled) {} else log_output_file << getTimeStamp() 
#define log_debug if (log_output_disabled) {} else log_output_file << getTimeStamp() 
#define log_error if (log_output_disabled) {} else log_output_file << getTimeStamp() 

void logging_start();
void logging_end();