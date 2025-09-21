const std = @import("std");
const vec3 = @import("vector_util.zig");
const vec_3_f32 = @Vector(3, f32);

const image_width: u32 = 1024;
const image_height: u32 = 960;
var tmp: [128]u8 = undefined;

pub fn main() !void {
    var file = try std.fs.cwd().createFile("out.ppm", .{ .truncate = true });
    defer file.close();

    var line = try std.fmt.bufPrint(&tmp, "{s}\n", .{"P3"});
    _ = try file.write(line);

    line = try std.fmt.bufPrint(&tmp, "{d} {d}\n{d}\n", .{ image_width, image_height, 255 });
    _ = try file.write(line);

    const img_ht_f: f64 = @as(f64, @floatFromInt((image_height)));
    const img_wd_f: f64 = @as(f64, @floatFromInt((image_width)));

    for (0..image_height) |x| {
        std.debug.print("Rendering {d}/{d} lines\r", .{ x + 1, image_height });
        for (0..image_width) |y| {
            const x_f: f64 = @as(f64, @floatFromInt(x));
            const y_f: f64 = @as(f64, @floatFromInt(y));

            const red = x_f / (img_wd_f - 1.0);
            const green = y_f / (img_ht_f - 1.0);
            const blue = 0.0;

            const r_px: usize = @intFromFloat(@floor(red * 255.99));
            const g_px: usize = @intFromFloat(@floor(green * 255.99));
            const b_px: usize = @intFromFloat(@floor(blue * 255.99));

            line = try std.fmt.bufPrint(&tmp, "{d} {d} {d}\n", .{ r_px, g_px, b_px });
            _ = try file.write(line);
        }
    }
    std.debug.print("\n", .{});
    try file.sync();
}
