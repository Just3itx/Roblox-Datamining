-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    FRAME_BUCKET_KEYS = {
        "under_16",
        "16_to_16_7",
        "16_7_to_17_5",
        "17_5_to_18",
        "18_to_21",
        "21_to_25",
        "over_25"
    },
    JANKY_FRAME_BANDS = { ["18_to_21"] = true, ["21_to_25"] = true, over_25 = true }
}
