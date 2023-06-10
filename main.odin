package main 

import "core:fmt"


main :: proc() {
    //Image
    image_width :: 256
    image_height :: 256

    //Render
    fmt.print("P3\n",image_width,' ', image_height,"\n255\n")

    for j := image_height-1; j >= 0; j -= 1{
        for i := 0; i < image_width; i += 1{
            r := f64(i) / (image_width -1)
            g := f64(j) / (image_height-1)
            b := 0.25

            ir := int(255.999 * r)
            ig := int(255.999 * g)
            ib := int(255.999 * b)

            fmt.print(ir, ' ', ig, ' ', ib,'\n')
        }
    }

    
}