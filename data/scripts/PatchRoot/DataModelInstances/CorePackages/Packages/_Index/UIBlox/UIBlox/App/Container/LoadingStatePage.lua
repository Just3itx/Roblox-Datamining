-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Loading = Foundation.Loading
local IconSize = Foundation.Enums.IconSize

local var1 = Roact.PureComponent:extend("LoadingStatePage")

function var1.render(_)
    return Roact.createElement(
        Loading,
        {
            size = IconSize.Medium,
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        }
    )
end
return var1
