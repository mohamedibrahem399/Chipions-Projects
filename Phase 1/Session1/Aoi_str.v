module Aoi_str_2005 (output y_out,input x_in1,x_in2,x_in3,x_in4,x_in5);
 wire y1,y2;

   nor (y_out,y1,y2);
   and (y1,x_in1,x_in2);
   and(y2,x_in3,x_in4,x_in5);

 endmodule
