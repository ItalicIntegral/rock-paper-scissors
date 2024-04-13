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

//const RockPaperScissorsError = error{InvalidChoice};

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
