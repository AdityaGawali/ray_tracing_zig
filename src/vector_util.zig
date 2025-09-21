const std = @import("std");
const vec_3_f32 = @Vector(3, f32);

const DivideError = error{DivideByZero};

pub fn add(a: vec_3_f32, b: vec_3_f32) vec_3_f32 {
    return a + b;
}

pub fn sub(a: vec_3_f32, b: vec_3_f32) vec_3_f32 {
    return a - b;
}

pub fn scal_mult(a: vec_3_f32, b: f32) vec_3_f32 {
    return a * b;
}

pub fn get_x(a: vec_3_f32) f32 {
    return a[0];
}

pub fn get_y(a: vec_3_f32) f32 {
    return a[1];
}

pub fn get_z(a: vec_3_f32) f32 {
    return a[2];
}

pub fn dot_prod(a: vec_3_f32, b: vec_3_f32) f32 {
    return @reduce(.Add, a * b);
}

pub fn cross_prod(a: vec_3_f32, b: vec_3_f32) vec_3_f32 {
    const x_component = a[1] * b[2] - a[2] * b[1];
    const y_component = a[2] * b[0] - a[0] * b[2];
    const z_component = a[0] * b[1] - a[1] * b[0];
    return vec_3_f32{ x_component, y_component, z_component };
}

pub fn get_len(a: vec_3_f32) f32 {
    return @sqrt(@reduce(.Add, a * a));
}

pub fn get_len_squared(a: vec_3_f32) f32 {
    return @reduce(.Add, a * a);
}

pub fn normalize(a: vec_3_f32) DivideError!vec_3_f32 {
    const norm2: f32 = @reduce(.Add, a * a);
    const norm: f32 = @sqrt(norm2);
    if (norm == 0.0) {
        return DivideError.DivideByZero;
    }
    const norm_vec: vec_3_f32 = @as(vec_3_f32, @splat(norm));
    return a / norm_vec;
}
pub fn print_vec(vec: vec_3_f32) void {
    std.debug.print("x={d:.2} y={d:.2} z={d:.2}\n", .{ vec[0], vec[1], vec[2] });
}
pub fn print_scal(a: f32) void {
    std.debug.print("value={d:.2}\n", .{a});
}
