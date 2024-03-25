# Copyright (C) 2005 - 2021 Settlers Freaks <sf-team at siedler25.org>
#
# SPDX-License-Identifier: GPL-2.0-or-later

# Arm specific configs. Values taken from https://gist.github.com/fm4dd/c663217935dc17f0fc73c9c81b0aa845
#
# Functions: get_arm_tune (cpu as tune target), get_arm_fpu (fpu target), get_arm_flags (full arm-specific optimization)

set(RTTR_AVAILABLE_ARM_CFGS OFF Generic RasPi1 RasPi2 RasPi3 RasPi4 RasPi5 BBBlack AltCycloneV5)
macro(get_arm_tune result target)
    if(target STREQUAL "RasPi1")
        set(${result} arm1176jzf-s)
    elseif(target STREQUAL "RasPi2")
        set(${result} cortex-a7)
    elseif(target STREQUAL "RasPi3")
        set(${result} cortex-a53)
    elseif(target STREQUAL "RasPi4")
        set(${result} cortex-a72)
    elseif(target STREQUAL "RasPi5")
        set(${result} cortex-a76)
    elseif(target STREQUAL "BBBlack")
        set(${result} cortex-a8)
    elseif(target STREQUAL "AltCycloneV5")
        set(${result} cortex-a9)
    elseif(target STREQUAL "Generic")
        set(${result} generic)
    else()
        set(${result} "")
    endif()
endmacro()

macro(get_arm_fpu result target)
    if(target STREQUAL "RasPi1")
        set(${result} vfp)
    elseif(target STREQUAL "RasPi2")
        set(${result} neon-vfpv4)
    elseif(target MATCHES "RasPi[3-5]")
        set(${result} neon-fp-armv8)
    elseif(target STREQUAL "BBBlack" OR target STREQUAL "AltCycloneV5")
        set(${result} neon)
    else()
        set(${result} "")
    endif()
endmacro()

function(get_arm_flags result target)
    unset(_result)
    get_arm_tune(cpu ${target})
    if(cpu AND NOT CPU STREQUAL "generic")
        list(APPEND _result -mcpu=${cpu})
    endif()
    get_arm_fpu(fpu ${target})
    if(fpu)
        list(APPEND _result -mfpu=${fpu})
    endif()
    if(target MATCHES "RasPi[1-5]|BBBlack|AltCycloneV5")
        list(APPEND _result -mfloat-abi=hard)
    endif()
    if(target MATCHES "RasPi[3-5]")
        list(APPEND _result -mneon-for-64bits)
    endif()
    set(${result} "${_result}" PARENT_SCOPE)
endfunction()
