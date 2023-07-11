# PCI-bus-Arbiter-using-Verilog
The PCI Bus Arbiter is a component responsible for managing access to the PCI (Peripheral Component Interconnect) bus in a computer system. The PCI bus is a standard interface that allows various peripheral devices, such as video grabber, video codec and fire wire, to communicate with the CPU and memory.
In a microprocessor environment, several processors share the same system bus such as a PCI bus.
The PCI Bus Arbiter is typically implemented as part of the chipset on the motherboard or as a separate integrated circuit. Its primary function is to facilitate efficient and fair bus access, preventing conflicts and ensuring smooth communication between the CPU and peripheral devices connected to the PCI bus.

The PCI Bus Arbiter uses a priority-based arbitration scheme to determine which device gets access to the bus at a given time.
Each device on the bus is assigned a priority level, and the arbiter uses this information to decide which device should be granted access.
When a device needs to access the bus, it signals its request to the arbiter. The arbiter then compares the priority of the requesting device with the priorities of other devices that have also requested access or are currently using the bus. Based on the priority comparison, the arbiter grants access to the highest-priority device.

Bus Arbitration is the process by which the next device to become the bus master and bus mastership is transferred to it.
the selection of the bus master take into account the need of various device by establishing a priority system for gaining access to the bus.


Working principle

The four masters mentioned earlier request the arbiter before using the PCI bus by asserting the signals REQ0 through REQ3. 
The arbiter looks into the priority assigned for each request and asserts one of the grant signals, GNT0 through GNT3.
After the CPU accesses the PCI bus, the priority sequence repeats from step 1. 
The Video Grabber VG and Codec VC access the bus more frequently than the Fire Wire and the host processor since the raw data and compression/decompression have to be processed immediately.



