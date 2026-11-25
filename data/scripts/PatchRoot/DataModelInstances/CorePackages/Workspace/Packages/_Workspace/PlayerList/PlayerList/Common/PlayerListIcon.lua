-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)
local Foundation = require(scriptParentParentParent.Foundation)

local Image = Foundation.Image
local Icon = Foundation.Icon

local function PlayerListIcon(tbl1)
    local icon = tbl1.icon
    if icon == nil or icon == "" then
        return nil
    end
    local size = tbl1.size

    if typeof(icon) == "table" and icon.isFoundationIcon then
        return React.createElement(
            Icon,
            {
                name = icon.name,
                variant = icon.variant,
                size = size,
                LayoutOrder = tbl1.layoutOrder,
                testId = tbl1.testId
            }
        )
    elseif typeof(icon) == "string" then
        return React.createElement(
            Image,
            {
                Image = icon,
                Size = UDim2.fromOffset(size, size),
                LayoutOrder = tbl1.layoutOrder,
                testId = tbl1.testId
            }
        )
    elseif typeof(icon) == "table" and icon.Image ~= nil then
        return React.createElement(Image, {
            Image = icon.Image,
            imageRect = {
                offset = icon.ImageRectOffset,
                size = icon.ImageRectSize
            },
            Size = UDim2.fromOffset(size, size),
            LayoutOrder = tbl1.layoutOrder,
            testId = tbl1.testId
        })
    end

    return nil
end

return PlayerListIcon
