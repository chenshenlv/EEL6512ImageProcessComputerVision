[hist_norm,hist]=myhist('tools.pgm');% display normalized histogram
[ histeq_norm ] = myhisteq( 'tools.pgm' );% display normalized equalized histogram
[quant_output] = myquantize( 'tools.pgm',8 );%display quantilized image

