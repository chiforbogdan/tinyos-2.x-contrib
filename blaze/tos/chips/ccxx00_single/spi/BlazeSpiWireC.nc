/*
 * Copyright (c) 2005-2006 Rincon Research Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Rincon Research Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * RINCON RESEARCH OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */


#include "Blaze.h"

/**
 * Originally, BlazeSpiC was generic because of Resource so we had to have this
 * Consider folding this back into the BlazeSpiC configuration.
 * 
 * @author Jared Hill
 * @author David Moss
 */
configuration BlazeSpiWireC {

  provides interface BlazeFifo as Fifo[ uint8_t id ];
  provides interface BlazeRegister as Reg[ uint8_t id ];
  provides interface BlazeStrobe as Strobe[ uint8_t id ];
  provides interface RadioInit;
  provides interface ChipSpiResource;
  provides interface RadioStatus;
  
}

implementation {

  components BlazeSpiP;
  ChipSpiResource = BlazeSpiP;
  Fifo = BlazeSpiP;
  Reg = BlazeSpiP;
  Strobe = BlazeSpiP;
  RadioInit = BlazeSpiP;
  RadioStatus = BlazeSpiP;
    
  components HplRadioSpiC;
  BlazeSpiP.SpiResource -> HplRadioSpiC;
  BlazeSpiP.SpiByte -> HplRadioSpiC;
  BlazeSpiP.SpiPacket -> HplRadioSpiC;
    
  components LedsC;
  BlazeSpiP.Leds -> LedsC;
  
}
