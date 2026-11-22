-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")

local mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)

local createVideoNode = require(MomentsCommon.Media.Nodes.createVideoNode)
local createMusicNode = require(MomentsCommon.Media.Nodes.createMusicNode)
local createTtsNode = require(MomentsCommon.Media.Nodes.createTtsNode)
local createScreenshotNode = require(MomentsCommon.Media.Nodes.createScreenshotNode)
local createTextOverlayNode = require(MomentsCommon.Media.Nodes.createTextOverlayNode)
local createStickerOverlayNode = require(MomentsCommon.Media.Nodes.createStickerOverlayNode)
local GetFFlagMomentsStickerButton = require(MomentsCommon.Flags.GetFFlagMomentsStickerButton)

local function createDefaultMediaNodeRegistry()
    local var1 = mediaNodeRegistry()

    var1.register(createVideoNode)
    var1.register(createMusicNode)
    var1.register(createTtsNode)
    var1.register(createScreenshotNode)
    var1.register(createTextOverlayNode)
    if GetFFlagMomentsStickerButton() then
        var1.register(createStickerOverlayNode)
    end
    return var1
end

return createDefaultMediaNodeRegistry
