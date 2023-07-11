`timescale 1ns / 1ps
`define clkperiodby2 10 // 10 ns is the half time period (50 MHz). 
module pci_arbiter_test;
reg REQ0 ; // Declare all inputs of 
reg REQ1 ; // the design as registers. 
reg REQ2 ; 
reg REQ3 ; 
reg clk ; 
reg reset_n ; // Declare Bus Grant outputs as nets. 
wire GNT0 ; 
wire GNT1 ; 
wire GNT2 ; 
wire GNT3 ; 
pci_arbiter u1( // Instantiate the design module, calling ports by name. 
 .REQ0(REQ0) , // Inputs. 
 .REQ1(REQ1) , 
 .REQ2(REQ2) , 
 .REQ3(REQ3) , 
 .GNT0(GNT0) , // Outputs. 
 .GNT1(GNT1) , 
 .GNT2(GNT2) , 
 .GNT3(GNT3) , 
 .clk(clk) , // Inputs. 
 .reset_n(reset_n) 
 );
  always  #`clkperiodby2 clk <= !clk ; // Toggle to get a free running clk.  
 initial 
  begin 
  REQ0 = 1 ; // At time zero, let the request inputs 
  REQ1 = 1 ; // be active. 
  REQ2 = 1 ; 
  REQ3 = 1 ; 
  clk = 0 ; // Initialize clk, and reset_n. 
  reset_n = 1 ; 
  #60 reset_n = 0 ; // At 60 ns, apply reset. 
  #20 reset_n = 1 ; // At 80 ns, let the reset be withdrawn. 
  #400 REQ0 = 0 ; // At time 480 ns, let the request input be 0. 
  #80 REQ1 = 0 ; // At time 560 ns, let the request input be 0. 
  #80 REQ2 = 0 ; // At time 640 ns, let the request input be 0. 
 #160 REQ0 = 1 ; // At time 800 ns, let the request input be   // asserted again. 
 #200 REQ3 = 0 ; // At time 1000 ns, let the request input be 0. 
  #1200 // Run long enough to complete the test 
  $stop ; // and stop. 
  end 

endmodule
