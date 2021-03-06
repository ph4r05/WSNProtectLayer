/**
 * The basic abstraction for routing component. 
 * 
 * 	@version   0.1
 * 	@date      2012-2013
 */

#include "ProtectLayerGlobals.h"
configuration RouteC {
	provides {
		interface Init as PLInit;
		interface Route;
	}
}
implementation {   
	components RouteP;
	components SharedDataC;
	components RandomC;
	components DispatcherC;
	
	RouteP.Random -> RandomC.Random;
	RouteP.SharedData -> SharedDataC.SharedData;
	RouteP.Dispatcher -> DispatcherC;
	
	PLInit = RouteP.PLInit;
	Route = RouteP.Route;
	
#ifdef USE_CTP
	components CollectionC as Collector, new CollectionSenderC(AM_CTPRESPONSEMSG);
    
    RouteP.ForwardingControl -> Collector.StdControl;
    RouteP.RoutingInit -> Collector.RoutingInit;
    RouteP.ForwardingInit -> Collector.ForwardingInit;
    RouteP.LinkEstimatorInit -> Collector.LinkEstimatorInit;
    RouteP.CtpSend -> CollectionSenderC;
    RouteP.RootControl -> Collector;
  	RouteP.CtpInfo -> Collector;
    RouteP.CollectionPacket -> Collector;
    RouteP.CtpReceive -> Collector.Receive[AM_CTPRESPONSEMSG];
    RouteP.FixedTopology -> Collector.FixedTopology;

	components new TimerMilliC() as CtpSendTimer;
  	RouteP.CtpSendTimer -> CtpSendTimer;
  	components new TimerMilliC() as CtpInitTimer;
  	RouteP.CtpInitTimer -> CtpInitTimer;
	
	
#endif
}