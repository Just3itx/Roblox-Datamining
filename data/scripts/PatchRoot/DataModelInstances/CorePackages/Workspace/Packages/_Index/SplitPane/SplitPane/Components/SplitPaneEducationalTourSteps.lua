-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
local SplitPaneEducationalTourVideoAssetIds = require(script.Parent.Parent.Flags.SplitPaneEducationalTourVideoAssetIds)

return {
    {
        videoAssetId = SplitPaneEducationalTourVideoAssetIds.step1Video,
        gamepadVideoAssetId = SplitPaneEducationalTourVideoAssetIds.step1GamepadVideo,
        collapsedVideoAssetId = SplitPaneEducationalTourVideoAssetIds.step1CollapsedVideo,
        collapsedGamepadVideoAssetId = SplitPaneEducationalTourVideoAssetIds.step1CollapsedGamepadVideo
    },
    {
        videoAssetId = SplitPaneEducationalTourVideoAssetIds.step2Video,
        gamepadVideoAssetId = SplitPaneEducationalTourVideoAssetIds.step2GamepadVideo
    },
    {
        videoAssetId = SplitPaneEducationalTourVideoAssetIds.step3Video,
        gamepadVideoAssetId = SplitPaneEducationalTourVideoAssetIds.step3GamepadVideo,
        isFinal = true
    }
}
