-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParentParent.Cryo)

local tbl1 = {
    size = UDim2.fromScale(1, 1)
}

local function FooterFrame(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    return React.createElement("Frame", {
        Size = var1.size,
        Position = var1.position,
        AnchorPoint = var1.anchorPoint,
        LayoutOrder = var1.layoutOrder,
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }, var1.children)
end

return FooterFrame
