/**
 * Copyright (c) 2009 DEXMA SENSORS SL
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
 * - Neither the name of the DEXMA SENSORS SL nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * DEXMA SENSORS SL OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 */

/**
 * An HPL abstraction for USCI A/B shared vector interrupt on the MSP430X.
 *
 * @author Xavier Orduna <xorduna@dexmatech.com>
 */  
#include "msp430usci.h"

module HplMsp430UsciAB1RawInterruptsP @safe() {
  provides interface HplMsp430UsciRawInterrupts as UsciA;
  provides interface HplMsp430UsciRawInterrupts as UsciB;
}

implementation
{
  TOSH_SIGNAL(USCIAB1RX_VECTOR) {
    uint8_t temp;
    if (UC1IFG & UCA1RXIFG){
	    temp = UCA1RXBUF;
    	signal UsciA.rxDone(temp);
    }
    if (UC1IFG & UCB1RXIFG){
	    temp = UCB1RXBUF;
    	signal UsciB.rxDone(temp);
    }
  }
  
  TOSH_SIGNAL(USCIAB1TX_VECTOR) {
    if ((UC1IFG & UCA1TXIFG) | (UC1IFG & UCA1RXIFG)){
    	signal UsciA.txDone();
    }
    if ((UC1IFG & UCB1TXIFG) | (UC1IFG & UCB1RXIFG)){
    	signal UsciB.txDone();
    }
  }


  /* default handlers */
  default async event void UsciA.txDone(){
  	return;
  }
  
  default async event void UsciA.rxDone(uint8_t temp){
  	return;
  }

  default async event void UsciB.txDone(){
  	return;
  }
  
  default async event void UsciB.rxDone(uint8_t temp){
  	return;
  }
  
}
