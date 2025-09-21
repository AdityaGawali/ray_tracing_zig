const std = @import("std");

var tmp: [128]u8 = undefined;

const color = @Vector(3, usize);

pub fn get_red_color(c: color) usize {
    return c[0];
}

pub fn get_green_color(c: color) usize {
    return c[1];
}

pub fn get_blue_color(c: color) usize {
    return c[2];
}

pub fn rgb2px(red: f32, green: f32, blue: f32) color {
    const r = @as(usize, @intFromFloat(@floor(red * 255.99)));
    const g = @as(usize, @intFromFloat(@floor(green * 255.99)));
    const b = @as(usize, @intFromFloat(@floor(blue * 255.99)));
    return color{ r, g, b };
}

pub fn write_color(file: std.fs.File, c: color) !void {
    const line = try std.fmt.bufPrint(&tmp, "{d} {d} {d}\n", .{ get_red_color(c), get_green_color(c), get_blue_color(c) });
    _ = try file.write(line);
}
