const std = @import("std");

const inputbuffer = struct { buffer: *c_char, buffer_length: usize, input_length: usize };

fn read_input() ![]const u8 {
    const stdin = std.io.getStdIn().reader();
    const bare_line = try stdin.readUntilDelimiterAlloc(
        std.heap.page_allocator,
        '\n',
        8192,
    );
    const line = std.mem.trim(u8, bare_line, "\n");
    return line;
}

pub fn main() !void {
    // const input_buffer = inputbuffer{ .buffer = null, .input_length = 0, .buffer_length = 0 };

    while (true) {
        const line = try read_input();
        defer std.heap.page_allocator.free(line);

        if (std.mem.eql(u8, line[0..1], ".")) {
            std.debug.print("{s}", .{line[0..1]});
        }
    }
}

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
