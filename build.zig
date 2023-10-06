const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = std.Build.CompileStep.create(b, .{
        .name = "md4c",
        .kind = .lib,
        .linkage = .static,
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    // lib.installHeadersDirectory("src", "");
    lib.installHeader("src/md4c.h", "md4c.h");
    lib.installHeader("src/md4c-html.h", "md4c-html.h");
    lib.installHeader("src/entity.h", "entity.h");

    const sources = [_][]const u8{
        "src/md4c.c",
        "src/md4c-html.c",
        "src/entity.c",
    };

    lib.addCSourceFiles(&sources, &[_][]const u8{
        "-O2",
    });

    b.installArtifact(lib);
}
