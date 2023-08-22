class transaction;
  rand bit [10:0]rx_reg;
  logic [7:0]d_out;
  logic rd_en;
  logic rx;
  bit [10:0]rx_d_ref[];
 

constraint data_same{unique {rx_reg[8:1]};} 
//costant constraint 
	   constraint star_stop_bit{rx_reg[10]==1'b0; rx_reg[0]==1'b1;}
//good_parity_bit constraint 
	  constraint good_parity_bit{rx_reg[9]==^rx_reg[8:1];}
//Even parity type constraint 
// Odd parity type constraint 
  	  constraint count_even{($countones(rx_reg[8:1]))%2!=1'b1;} 
	  constraint count_odd{($countones(rx_reg[8:1]))%2==1'b1;} 
//Bad_parity_bit constraint 
	  constraint bad_parity_bit{rx_reg[9]==~^rx_reg[8:1];}
constraint range_data{rx_reg [8:1] dist {0:/1,[1:7]:/5,[8:15]:/5,[16:31]:/5,[32:63]:/4,[64:127]:/5,[128:252]:/4,253:/1};} 
  function void post_randomize();
    $display("%b %b %d %b, %b %h",rx_reg[10],rx_reg[9],rx_reg[8:1],rx_reg[0],rx_reg,rx_reg);
  endfunction 
endclass
