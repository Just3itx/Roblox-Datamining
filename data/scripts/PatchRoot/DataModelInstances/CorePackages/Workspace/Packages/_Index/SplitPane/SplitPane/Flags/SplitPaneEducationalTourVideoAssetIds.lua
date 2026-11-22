-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toVideoAssetId(str1: string, str2: string) -- Luacid: Inlined by compiler; 8 call sites recovered
    return "rbxassetid://" .. (string.match(str1, "^%s*(%d+)%s*$") or string.match(str1, "^%s*rbxassetid://(%d+)%s*$") or str2)
end

return {
    step1Video = toVideoAssetId(game:DefineFastString("SplitPaneTourStep1VideoAssetId", "106704716489493"), "106704716489493"),
    step1GamepadVideo = toVideoAssetId(game:DefineFastString("SplitPaneTourStep1GamepadVideoAssetId", "99301012574407"), "99301012574407"),
    step1CollapsedVideo = toVideoAssetId(game:DefineFastString("SplitPaneTourStep1CollapsedVideoAssetId", "123698805466599"), "123698805466599"),
    step1CollapsedGamepadVideo = toVideoAssetId(
        game:DefineFastString("SplitPaneTourStep1CollapsedGamepadVideoAssetId", "133523533509006"),
        "133523533509006"
    ),
    step2Video = toVideoAssetId(game:DefineFastString("SplitPaneTourStep2VideoAssetId", "91347423607736"), "91347423607736"),
    step2GamepadVideo = toVideoAssetId(game:DefineFastString("SplitPaneTourStep2GamepadVideoAssetId", "77203588287751"), "77203588287751"),
    step3Video = toVideoAssetId(game:DefineFastString("SplitPaneTourStep3VideoAssetId", "74337454749050"), "74337454749050"),
    step3GamepadVideo = toVideoAssetId(game:DefineFastString("SplitPaneTourStep3GamepadVideoAssetId", "139222920221400"), "139222920221400")
}
