/*
 * Copyright (c) 2006 Stanford University.
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
 * - Neither the name of the Stanford University nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL STANFORD
 * UNIVERSITY OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
/**
 * @author Philip Levis
 */

/**
 * The configuration that takes a underlying software Spi driver 
 * on Mulle and turns it into a shared abstraction.
 *
 * @author Henrik Makitaavola
 */

#include "MulleSpi.h"

generic configuration SoftSpiMasterP(char resourceName[])
{
  provides interface Resource[uint8_t client];
  provides interface SpiPacket[uint8_t client];
  provides interface SpiByte[uint8_t client];
  uses interface SoftSpiBus;
}
implementation
{
  components new FcfsArbiterC(resourceName) as Arbiter;
  components new AsyncPowerManagerP() as Power;
  components new SoftSpiMasterImplP() as Spi;
  components new SoftSpiMasterPacketP() as Master;
    
  Resource  = Spi;
  SpiPacket = Spi.SpiPacket;
  SpiByte = Spi.SpiByte;
  
  Spi.SubResource -> Arbiter;
  Spi.SubPacket   -> Master.SpiPacket;
  Spi.SubByte     -> Master.SpiByte;
  
  Power.AsyncStdControl -> Master;
  Power.ResourceDefaultOwner -> Arbiter;

  Master.Spi = SoftSpiBus;
}

