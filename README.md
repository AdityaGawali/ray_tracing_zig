## Ray tracing  in zig

[Ray Tracing in One Weekend](https://raytracing.github.io/books/RayTracingInOneWeekend.html)

Zig version `0.15.1`

- To build and run
```zig build run``` --> Generates `out.ppm`
- If ppm viewer is not available 
- download and install `imagemagick` 
  ```sudo apt install imagemagick ```
- Convert .ppm into png 
   ``` convert out.ppm out.png```

------------------------------------------------
#### Tasks Done
1. Write pixel data in ppm file
2. Add progress bar in loop
3. Add vector util 
4. Add color module
