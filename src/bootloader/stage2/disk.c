#include "disk.h"

void* ReadSector_HDD(const DiskHandler* Handler, const uint_t StartLBA, const uint_t NumberOfSectorsToRead, const void* Buffer) {
	void* buffer = NULL;
	// Check if BIOS compatible
	if(Handler->BIOS__DiskHandler == NULL && __SYS__BIOS_COMPATIBLE) {
		return NULL;
	}
	// Read Sector from HDD using BIOS Int 0x13
	if(asm_m16_int0x13_Check_for_EDD(Handler->BIOS__DiskHandler->Drive)) {
		// Calculate LBA parts for EDD
		uint16_t LBA_0;
		uint16_t LBA_1;
		uint16_t LBA_2;
		uint16_t LBA_3;
		// 32 Bit LBA
		LBA_0 = (uint16_t)0x0000;
		LBA_1 = (uint16_t)0x0000;
		LBA_2 = (uint16_t)((StartLBA >> 16) & 0xFFFF);
		LBA_3 = (uint16_t)(StartLBA & 0xFFFF);
		// Read with EDD
		buffer = asm_m16_int0x13_EDD_Read(Handler->BIOS__DiskHandler->Drive, LBA_0, LBA_1, LBA_2, LBA_3, NumberOfSectorsToRead, (void*)0x0500);
	}
	else {
		// Calculate CHS
		uint16_t cylinder;
		uint8_t head;
		uint8_t sector;
		convert_LBA_to_CHS(StartLBA, &cylinder, &head, &sector, Handler->CHS_Geometry);
		// Read with old INT 13h
		buffer = asm_m16_int0x13_Read(Handler->BIOS__DiskHandler->Drive, cylinder, head, sector, NumberOfSectorsToRead, (void*)0x0500);
	}
	return buffer;
}