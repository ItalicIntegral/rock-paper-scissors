// round.zig

const std = @import("std");
const stdin = std.io.getStdIn();
const reader = stdin.reader();
const RndGen = std.rand.DefaultPrng;
const main = @import("main.zig");

const RockPaperScissors = enum {
    Rock,
    Paper,
    Scissors,
};

const RoundResult = enum {
    Win,
    Lose,
    Tie,
};

pub fn PlayTurn() bool {
    if (GetPlayersChoice()) |playersChoice| {
        Result(playersChoice);
        return true;
    } else {
        return false;
    }
}

fn GetPlayersChoice() ?RockPaperScissors {
    const invalidEntryMessage =
        \\ Invalid entry.
        \\ Choices are: (R)ock, (P)aper, (S)cissors, (Q)uit
    ;

    var playersChoice: ?RockPaperScissors = undefined;

    var buffer: [8]u8 = undefined;
    while (true) {
        std.debug.print("\n\nMake your choice: ", .{});
        const result = reader.readUntilDelimiterOrEof(
            &buffer,
            '\n',
        );

        if (result) |r| {
            if (r) |s| {
                if (s.len == 0) unreachable;
                const choice = s[0];
                if (choice == 'Q' or choice == 'q') {
                    playersChoice = null;
                    main.playMode = false;
                    break;
                } else if (choice == 'R' or choice == 'r') {
                    playersChoice = RockPaperScissors.Rock;
                    break;
                } else if (choice == 'P' or choice == 'p') {
                    playersChoice = RockPaperScissors.Paper;
                    break;
                } else if (choice == 'S' or choice == 's') {
                    playersChoice = RockPaperScissors.Scissors;
                    break;
                } else {
                    std.debug.print(invalidEntryMessage, .{});
                }
            } else unreachable;
        } else |err| {
            std.debug.print("{}\n", .{err});
            unreachable;
        }
    }

    // std.debug.print("playersChoice: {}\n", .{playersChoice});
    return playersChoice;
}

fn GetComputersChoice() RockPaperScissors {
    var rand = std.rand.DefaultPrng.init(@as(u64, @bitCast(std.time.milliTimestamp())));
    const randomNumber = @mod(rand.random().int(i32), 3);
    // std.debug.print("random number is: {}\n", .{randomNumber});
    const computersChoice = switch (randomNumber) {
        0 => RockPaperScissors.Rock,
        1 => RockPaperScissors.Paper,
        2 => RockPaperScissors.Scissors,
        else => unreachable,
    };
    // std.debug.print("{}", .{computersChoice});
    return computersChoice;
}

fn Result(pChoice: RockPaperScissors) void {
    const results =
        \\        You played:  {s:8}
        \\   Computer played:  {s:8}     {s:4}              Score: p:{} c:{}
        \\
    ;

    const cChoice = GetComputersChoice();
    // std.debug.print("cChoice: {any}\n", .{cChoice});
    // std.debug.print("pChoice: {any}\n", .{pChoice});

    var wlt: RoundResult = undefined;
    if (pChoice == cChoice) {
        wlt = RoundResult.Tie;
    } else if (pChoice == RockPaperScissors.Rock and cChoice == RockPaperScissors.Scissors) {
        wlt = RoundResult.Win;
    } else if (pChoice == RockPaperScissors.Paper and cChoice == RockPaperScissors.Rock) {
        wlt = RoundResult.Win;
    } else if (pChoice == RockPaperScissors.Scissors and cChoice == RockPaperScissors.Paper) {
        wlt = RoundResult.Win;
    } else {
        wlt = RoundResult.Lose;
    }

    if (wlt == RoundResult.Tie) {
        // Nothing needs doing.
    } else if (wlt == RoundResult.Win) {
        main.playerScore += 1;
    } else if (wlt == RoundResult.Lose) {
        main.computerScore += 1;
    }

    // std.debug.print(results, .{ pChoice, cChoice, wlt, playerScore, computerScore });
    std.debug.print(results, .{
        @tagName(pChoice),
        @tagName(cChoice),
        @tagName(wlt),
        main.playerScore,
        main.computerScore,
    });
}
