/** 
 *  Wiring component for cryptographic functions providing CryptoRaw interface via CryptoRawP implementation.
 *  This component wires CryptoRawC to implementation from CryptoRawP and connects to Init interface for automatic initialization.
 *  @version   0.1
 * 	@date      2012-2013
 */
#include "ProtectLayerGlobals.h"
configuration CryptoRawC {
	provides {
		interface Init;
		interface CryptoRaw;
	}	
}
implementation {
	components MainC;   
	components CryptoRawP;
	components AESC;
	
	MainC.SoftwareInit -> CryptoRawP.Init;	//auto-initialization
	
	Init = CryptoRawP.Init;
	CryptoRaw = CryptoRawP.CryptoRaw;
	
	CryptoRawP.AES -> AESC.AES;
	
}
