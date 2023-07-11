`timescale 1ns / 1ps

module pci_arbiter(clk, reset_n, REQ0, REQ1, REQ2, REQ3,
 GNT0, GNT1, GNT2, GNT3 ) ; 
input clk ,reset_n ,REQ0 ,REQ1 ,REQ2, REQ3 ; 
output GNT0 , GNT1 ,GNT2 ,GNT3 ; 
reg GNT0 ;  
reg GNT1 ; 
reg GNT2 ; 
reg GNT3 ; 
reg [2:0]arbiter_state ; // State declaration.
always @ (posedge clk or negedge reset_n) 
begin 
    if (reset_n == 0) 
         begin // Switch OFF all grant signals to start with. 
            GNT0 <= 0 ; 
            GNT1 <= 0 ; 
            GNT2 <= 0 ; 
            GNT3 <= 0 ; 
            arbiter_state <= 0 ;  
        end 
   else 
         case (arbiter_state) 
         0:    begin // Wait state.   // Switch OFF all grants signals.
                  GNT0 <= 0 ; 
                  GNT1 <= 0 ; 
                  GNT2 <= 0 ; 
                  GNT3 <= 0 ; 
                 if (REQ0 == 1)      // If Video Grabber request is asserted, // go to the Video Grabber state "1". 
                    arbiter_state <= 1 ; // Otherwise, go to the Video Codec, state "2". 
                 else if (REQ1 == 1) 
                    arbiter_state <= 2 ; // Otherwise, go to the Fire Wire, state "3". 
                 else if (REQ2 == 1) 
                    arbiter_state <= 3 ; // Otherwise, go to the Host (CPU), state "4". 
                 else if (REQ3 == 1) 
                    arbiter_state <= 4 ;  // Otherwise, go to the WAIT, state "0". 
                 else 
                    arbiter_state <= 0 ; 
                 end 
        1:    begin // Switch OFF all grant signals // except that of Video Grabber. 
                GNT0 <= 1 ; 
                GNT1 <= 0 ; 
                GNT2 <= 0 ; 
                GNT3 <= 0 ; 
                if (REQ0 == 1) // If Video Grabber request is still asserted, // remain in the Video Grabber state "1". 
                  arbiter_state <= 1 ; // Otherwise, go to the Video Codec, state "2". 
                else if (REQ1 == 1) 
                   arbiter_state <= 2 ;  // Otherwise, go to the Fire Wire, state "3". 
                 else if (REQ2 == 1) 
                     arbiter_state <= 3 ; // Otherwise, go to the Host (CPU), state "4". 
                else if (REQ3 == 1) 
                    arbiter_state <= 4 ; // Otherwise, go to the VG, state "1". 
                else 
                     arbiter_state <= 1 ; 
              end 
         2:    begin // Switch OFF all grant signals // except that of Video Codec. 
                  GNT0 <= 0 ; 
                  GNT1 <= 1 ; 
                  GNT2 <= 0 ; 
                  GNT3 <= 0 ; 
                 if (REQ1 == 1) // If Video Codec request is still asserted, remain in the Video Codec state "2". 
                      arbiter_state <= 2 ;   // Otherwise, go to the Fire Wire state "3". 
                 else if (REQ2 == 1) 
                        arbiter_state <= 3 ;  // Otherwise, go to the CPU state "4". 
                 else if (REQ3 == 1) 
                    arbiter_state <= 4 ; // Otherwise, go to the VG state "1". 
                else 
                    arbiter_state <= 1 ; 
                end 
         3:     begin // Switch OFF all grant signals except Fire Wire. 
                     GNT0 <= 0 ; 
                     GNT1 <= 0 ; 
                     GNT2 <= 1 ; 
                     GNT3 <= 0 ; 
                     if (REQ2 == 1)  // If Fire Wire request is still asserted, remain in the Fire Wire state "3". 
                        arbiter_state <= 3 ; // Otherwise, go to the Video Grabber, state "1". 
                     else if (REQ0 == 1) 
                        arbiter_state <= 1 ; // Otherwise, go to the Video Codec, state "2". 
                     else if (REQ1 == 1) 
                        arbiter_state <= 2 ; // Otherwise, go to the Host (CPU), state "4". 
                     else if (REQ3 == 1) 
                        arbiter_state <= 4 ; // Otherwise, go to the VG state "1". 
                     else 
                        arbiter_state <= 1 ; 
                 end 
        4:      begin // Switch OFF all grant signals except  // that for the Host. 
                GNT0 <= 0 ; 
                GNT1 <= 0 ; 
                GNT2 <= 0 ; 
                GNT3 <= 1 ; 
                if (REQ3 == 1) // If CPU request is still asserted, remain in the CPU state "4". 
                    arbiter_state <= 4 ; // Otherwise, go to the VG state "1". 
                else 
                    arbiter_state <= 1 ; 
                end 
       default: arbiter_state <= 0 ;  // Otherwise, remain in the WAIT state. 
   endcase 
   end 
   endmodule 
 
