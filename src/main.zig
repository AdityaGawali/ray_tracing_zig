const std = @import("std");
const vec3 = @import("vector_util.zig");
const col = @import("color.zig");

const vec_3_f32 = @Vector(3, f32);

const image_width: u32 = 1024;
const image_height: u32 = 960;
var tmp: [128]u8 = undefined;

pub fn generate_ppm_hdr(file: std.fs.File, img_w: u32, img_h: u32) !void {
    var line = try std.fmt.bufPrint(&tmp, "{s}\n", .{"P3"});
    _ = try file.write(line);

    line = try std.fmt.bufPrint(&tmp, "{d} {d}\n{d}\n", .{ img_w, img_h, 255 });
    _ = try file.write(line);
}

pub fn main() !void {
    var file = try std.fs.cwd().createFile("out.ppm", .{ .truncate = true });
    defer file.close();

    try generate_ppm_hdr(file, image_width, image_height);

    const img_ht_f: f32 = @as(f32, @floatFromInt((image_height)));
    const img_wd_f: f32 = @as(f32, @floatFromInt((image_width)));

    for (0..image_height) |x| {
        std.debug.print("Rendering {d}/{d} lines\r", .{ x + 1, image_height });
        for (0..image_width) |y| {
            const x_f: f32 = @as(f32, @floatFromInt(x));
            const y_f: f32 = @as(f32, @floatFromInt(y));

            const red = x_f / (img_wd_f - 1.0);
            const blue = y_f / (img_ht_f - 1.0);
            const green = 0.0;

            const pixel = col.rgb2px(red, green, blue);
            try col.write_color(file, pixel);
        }
    }
    std.debug.print("\n", .{});
    try file.sync();
}
