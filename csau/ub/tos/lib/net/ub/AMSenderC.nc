// $Id$
/*
 * "Copyright (c) 2006 Stanford University. All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL STANFORD UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN
 * IF STANFORD UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 * 
 * STANFORD UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND STANFORD UNIVERSITY
 * HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES,
 * ENHANCEMENTS, OR MODIFICATIONS."
 */

/**
 * The virtualized active message send abstraction. Each instantiation
 * of AMSenderC has its own queue of depth one. Therefore, it does not
 * have to contend with other AMSenderC instantiations for queue space.
 * The underlying implementation schedules the packets in these queues
 * using some form of fair-share queueing.
 *
 * @author Philip Levis
 * @date   Jan 16 2006
 * @see    TEP 116: Packet Protocols
 */ 

#include "AM.h"

generic configuration AMSenderC(am_id_t AMId) {
  provides {
    interface AMSend;
    interface Packet;
    interface AMPacket;
    interface PacketAcknowledgements as Acks;
		interface UnifiedBroadcast;
  }
}

implementation {

#if defined(LOW_POWER_LISTENING)
  components new LplAMSenderC(AMId) as SenderC;
#else
  components new DirectAMSenderC(AMId) as SenderC;
#endif

  AMSend = SenderC;
  Packet = SenderC;
  AMPacket = SenderC;
  Acks = SenderC;
	UnifiedBroadcast = SenderC;
}
