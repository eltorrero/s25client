# this one is important
SET(CMAKE_SYSTEM_NAME Darwin)
SET(CMAKE_SYSTEM_PROCESSOR x86_64)

SET(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE STRING "OSX-Architectures")

# set compilers...
INCLUDE("${CMAKE_CURRENT_LIST_DIR}/c.apple.common.cmake")
