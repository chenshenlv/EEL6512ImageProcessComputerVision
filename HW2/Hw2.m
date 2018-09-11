[hist_norm,hist]=myhist('tools.pgm');% display normalized histogram
[ histeq_norm ] = myhisteq( 'tools.pgm' );% display normalized equalized histogram
[quant_output] = myquantize( 'flower.pgm',8 );%display quantilized image

