package main 

import "core:fmt"
import "core:os"
import m "core:math"


length :: proc(x: [3]f64) -> f64{
    return m.sqrt_f64(length_squared(x))

}

length_squared :: proc(x :[3]f64) -> f64{
    x := x
    x*= x
    return x.x + x.y +x.z
}


unit_vector :: proc(x: [3]f64) -> [3]f64 {
    x:= x
    return x/ length(x)

}   

Ray :: struct{
    origin : [3]f64, 
    dir : [3]f64,
}

ray_color :: proc(r :^Ray) -> [3]f64{
    unit_dir := unit_vector(r.dir)
    t := 0.5 *(unit_dir.y + 1.0)

    return (1.0 - t) * [3]f64{1.0,1.0,1.0} + t* [3]f64{0.5,0.7,1.0}


}

write_color :: proc(pxl_col: [3]f64) {
        
    fmt.print(i64(255.999 * pxl_col.x), ' ', i64(255.999 * pxl_col.y), ' ', i64(255.999 * pxl_col.z),'\n')
}

main :: proc() {
    //Image
    aspect_ratio :: 16.0 / 9.0
    image_width :: 400
    image_height :: int(image_width/aspect_ratio)


    //Camera
    viewport_height := 2.0
    viewport_width := aspect_ratio * viewport_height
    focal_length := 1.0

    origin :[3]f64 = {0,0,0}
    horizontal :[3]f64={viewport_width,0,0}
    vertical :[3]f64= {0,viewport_height,0}
    lower_left_corner := origin - horizontal/2 - vertical/2 - [3]f64{0,0,focal_length}

    

   
    //Render


    vec3  : [3]f64
    ivec3 : [3]i64


    fmt.print("P3\n",image_width,' ', image_height,"\n255\n")

    for j := image_height-1; j >= 0; j -= 1{

        fmt.eprint("\rScanlines remaining:", j , ' ')

        for i := 0; i < image_width; i += 1{



            u := f64(i) / f64(image_width -1)
            v := f64(j) / f64(image_height -1)
             r:= Ray{origin, lower_left_corner + u*horizontal+v*vertical - origin}

            pxl_col := ray_color(&r)
            write_color(pxl_col)

            

           // vec3 = {f64(i) / (image_width -1),f64(j) / (image_height-1),0.25}
            


            //ivec3 = {i64(255.999 * vec3.x),i64(255.999 * vec3.y),i64(255.999 * vec3.z)}
            

            //fmt.print(ivec3.x, ' ', ivec3.y, ' ', ivec3.z,'\n')
        }
    }

    fmt.eprint("\nDone.\n")

    
}


