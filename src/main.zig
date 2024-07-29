const std = @import("std");
const round = @import("round.zig");

const title =
    \\ROCK PAPER SCISSORS
    \\by: Ben
    \\Choices are: (R)ock, (P)aper, (S)cissors, (Q)uit
;

pub var pScore: u16 = 0;
pub var cScore: u16 = 0;
pub var playMode: bool = true;

const RockPaperScissorsError = error{InvalidChoice};

pub fn main() !void {
    std.debug.print("{s}\n", .{title});

    while (playMode and round.PlayTurn()) {
        if (pScore == 3) {
            std.debug.print("\nPlayer Wins!\n\n", .{});
            break;
        }
        if (cScore == 3) {
            std.debug.print("\nComputer Wins!\n\n", .{});
            break;
        }
    }
}

// const std = @import("std");

// pub fn main() !void {
//     // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
//     std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

//     // stdout is for the actual output of your application, for example if you
//     // are implementing gzip, then only the compressed bytes should be sent to
//     // stdout, not any debugging messages.
//     const stdout_file = std.io.getStdOut().writer();
//     var bw = std.io.bufferedWriter(stdout_file);
//     const stdout = bw.writer();

//     try stdout.print("Run `zig build test` to run the tests.\n", .{});

//     try bw.flush(); // don't forget to flush!
// }

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
