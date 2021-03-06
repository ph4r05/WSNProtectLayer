/**
 * Setting of the Configuration module to SerialAM (USB).
 * 
 * 	@version   0.1
 * 	@date      2012-2013
 */
#include "ProtectLayerGlobals.h"
configuration ConfigurationC{
	provides {
		// interface Init;
		interface Configuration;
	}
}

implementation{
	components ConfigurationP;
	components new SerialAMSenderC(AM_CON_SD_MSG) as ConfSDSend;
	components new SerialAMSenderC(AM_CON_PPCPD_MSG) as ConfPPCPDSend;
	components new SerialAMSenderC(AM_CON_RPD_MSG) as ConfRPDSend;
	components new SerialAMSenderC(AM_CON_KDCPD_MSG) as ConfKDCPDSend;
	components new SerialAMReceiverC(AM_CON_GET_MSG) as ConfGet;
	components new SerialAMReceiverC(AM_CON_SD_MSG) as ConfSDGet;
	components new SerialAMReceiverC(AM_CON_PPCPD_MSG) as ConfPPCPDGet;
	components new SerialAMReceiverC(AM_CON_RPD_MSG) as ConfRPDGet;
	components new SerialAMReceiverC(AM_CON_KDCPD_MSG) as ConfKDCPDGet;
	components SerialActiveMessageC;
	components SharedDataC;
	components LedsC;
	//queue for the entire combined data
	components new QueueC(message_t, MAX_NEIGHBOR_COUNT + 3);
	components MainC;
		
	// Init = ConfigurationP.Init;
	
	MainC.SoftwareInit -> ConfigurationP.Init; // auto init phase 1
	
	ConfigurationP.ConfSDSend -> ConfSDSend;
	ConfigurationP.PacketSD -> ConfSDSend;
	ConfigurationP.AMPacket -> ConfSDSend;
	ConfigurationP.Acks -> ConfSDSend;
	
	ConfigurationP.ConfPPCPDSend -> ConfPPCPDSend;
	ConfigurationP.ConfRPDSend -> ConfRPDSend;
	ConfigurationP.ConfKDCPDSend -> ConfKDCPDSend;
	
	ConfigurationP.PacketPPCPD -> ConfPPCPDSend;
	ConfigurationP.PacketRPD -> ConfRPDSend;
	ConfigurationP.PacketKDCPD -> ConfKDCPDSend;
	
	ConfigurationP.ConfGet -> ConfGet;
	ConfigurationP.ConfSDGet -> ConfSDGet;
	ConfigurationP.ConfPPCPDGet -> ConfPPCPDGet;
	ConfigurationP.PacketRPD -> ConfRPDSend;
	ConfigurationP.ConfKDCPDGet -> ConfKDCPDGet;
	
	ConfigurationP.SerialControl -> SerialActiveMessageC;
	
	ConfigurationP.SharedData -> SharedDataC.SharedData;
	
	ConfigurationP.Leds -> LedsC;
	
	ConfigurationP.Queue -> QueueC;
	
	Configuration = ConfigurationP.Configuration;
}