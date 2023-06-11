package main 

import "core:fmt"
import "core:os"


main :: proc() {
    //Image
    image_width :: 256
    image_height :: 256



    //Render
    vec3 : [3]f64
    ivec3 :[3]i64

    fmt.print("P3\n",image_width,' ', image_height,"\n255\n")

    for j := image_height-1; j >= 0; j -= 1{

        fmt.eprint("\rScanlines remaining:", j , ' ')

        for i := 0; i < image_width; i += 1{

            vec3 = {f64(i) / (image_width -1),f64(j) / (image_height-1),0.25}
            


            ivec3 = {i64(255.999 * vec3.x),i64(255.999 * vec3.y),i64(255.999 * vec3.z)}
            

            fmt.print(ivec3.x, ' ', ivec3.y, ' ', ivec3.z,'\n')
        }
    }

    fmt.eprint("\nDone.\n")

    
}


