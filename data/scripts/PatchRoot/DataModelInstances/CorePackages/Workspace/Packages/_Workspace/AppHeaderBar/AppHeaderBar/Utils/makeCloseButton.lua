-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)

local Images = UIBlox.App.ImageSet.Images
local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize

local function makeCloseButton(onActivated: ((...any) -> (...any))?)
    return function()
        return React.createElement(IconButton, {
            size = UDim2.fromOffset(0, 0),
            iconSize = IconSize.Medium,
            icon = Images["icons/navigation/close"],
            onActivated = onActivated
        })
    end
end

return makeCloseButton
