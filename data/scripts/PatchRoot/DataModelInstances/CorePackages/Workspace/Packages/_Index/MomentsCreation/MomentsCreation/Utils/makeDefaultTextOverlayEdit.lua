-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")

local Constants = require(MomentsCreation.Constants)

local _MomentsTypes = require(MomentsCreation.Parent.MomentsTypes)

local function makeDefaultTextOverlayEdit()
    return {
        position = UDim2.fromScale(0.5, 0.5),
        rotation = 0,
        scale = 1,
        text = "",
        textOverlayStyle = {
            font = Enum.Font.BuilderSansMedium,
            fontColor = Color3.new(0, 0, 0),
            fontSize = Constants.TextOverlay.DefaultFontSize,
            textXAlignment = Enum.TextXAlignment.Center
        },
        zIndex = 1
    }
end

return makeDefaultTextOverlayEdit
