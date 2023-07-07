package main 

import "core:fmt"
import "core:os"
import m "core:math"
import l "core:math/linalg/hlsl"


length :: proc(x: l.float3) -> f32{
    return m.sqrt_f32(length_squared(x))

}

length_squared :: proc(x :l.float3) -> f32{
    x := x
    x*= x
    return x.x + x.y +x.z
}


unit_vector :: proc(x: l.float3) -> l.float3 {
    x:= x
    return x/ length(x)

}   

Ray :: struct{
    origin : l.float3, 
    dir : l.float3,
}

ray_color :: proc(r :^Ray) -> l.float3{
    t := hit_sphere(l.float3{0,0,-1},0.5,r)
    if t> 0.0 {
        N := unit_vector(at(t,r) - l.float3{0,0,-1})
        return 0.5* l.float3{N.x + 1, N.y + 1, N.z +1}
    }
    
    /* if hit_sphere(l.float3{0,0,-1},0.5,r){

        return l.float3{1,0,0}
    }*/
    unit_dir := unit_vector(r.dir)
    t = 0.5 *(unit_dir.y + 1.0)
    return (1.0 - t) * l.float3{1.0,1.0,1.0} + t* l.float3{0.5,0.7,1.0}


}

at :: proc(t: f32,r: ^Ray) -> l.float3{
    return r.origin + t*r.dir

}

write_color :: proc(pxl_col: l.float3) {
        
    fmt.print(i64(255.999 * pxl_col.x), ' ', i64(255.999 * pxl_col.y), ' ', i64(255.999 * pxl_col.z),'\n')
}

hit_sphere :: proc( center :l.float3,radius:f32, r : ^Ray) -> f32{
    oc := r.origin - center
    a := l.dot(r.dir,r.dir)
    b := f32(2.0 * l.dot(oc,r.dir))
    c := f32(l.dot(oc,oc) - radius*radius)
    discriminant := b*b - 4*a*c
    if discriminant < 0{
        return -1.0
    }else{
        return (-b -m.sqrt(discriminant)) /(2.0*a)
    }
    
    
}

main :: proc() {
    //Image
    aspect_ratio :: 16.0 / 9.0
    image_width :: 400
    image_height :: int(image_width/aspect_ratio)


    //Camera
    viewport_height :f32= 2.0
    viewport_width := f32(aspect_ratio * viewport_height)
    focal_length :f32= 1.0

    origin :l.float3 = {0,0,0}
    horizontal :l.float3={viewport_width,0,0}
    vertical :l.float3= {0,viewport_height,0}
    lower_left_corner := origin - horizontal/2 - vertical/2 - l.float3{0,0,focal_length}

    

   
    //Render


    vec3  : l.float3//l.float3
    ivec3 : [3]i64


    fmt.print("P3\n",image_width,' ', image_height,"\n255\n")

    for j := image_height-1; j >= 0; j -= 1{

        fmt.eprint("\rScanlines remaining:", j , ' ')

        for i := 0; i < image_width; i += 1{



            u := f32(i) / f32(image_width -1)
            v := f32(j) / f32(image_height -1)
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


