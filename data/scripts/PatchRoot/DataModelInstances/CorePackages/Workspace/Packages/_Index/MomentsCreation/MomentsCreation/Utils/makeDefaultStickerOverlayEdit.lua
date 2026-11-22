-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local Constants = require(MomentsCreation.Constants)

local _MomentsTypes = require(MomentsCreation.Parent.MomentsTypes)

local function makeDefaultStickerOverlayEdit()
    return {
        stickerURI = nil,
        position = UDim2.fromScale(0.5, 0.5),
        stickerSize = Constants.StickerOverlay.DefaultStickerSize,
        rotation = 0,
        scale = 1,
        zIndex = 1
    }
end

return makeDefaultStickerOverlayEdit
