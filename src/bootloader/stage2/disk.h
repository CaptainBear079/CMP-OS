#ifndef __SYS__SERVICES_DISK_H_
#define __SYS__SERVICES_DISK_H_

#include "asm.h"
#include "utils.h"
#include <stddef.h>

extern uint_t __SYS__SECTOR_SIZE;
extern bool __SYS__BIOS_COMPATIBLE;

void* ReadSector_HDD(const DiskHandler* Handler, const uint_t StartLBA, const uint_t NumberOfSectorsToRead, const void* Buffer);

#endif
