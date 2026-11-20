-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local getTestIdTag = require(Foundation.Utility.getTestIdTag)

local _Types = require(Foundation.Components.Types)

local function getPadding(arg1)
    if ReactIs.isBinding(arg1) then
        return { PaddingTop = arg1, PaddingBottom = arg1, PaddingLeft = arg1, PaddingRight = arg1 }
    end

    if typeof(arg1) == "table" then
        return {
            PaddingTop = arg1.top,
            PaddingBottom = arg1.bottom,
            PaddingLeft = arg1.left,
            PaddingRight = arg1.right
        }
    end

    if typeof(arg1) == "number" then
        return {
            PaddingTop = UDim.new(0, arg1),
            PaddingBottom = UDim.new(0, arg1),
            PaddingLeft = UDim.new(0, arg1),
            PaddingRight = UDim.new(0, arg1)
        }
    end

    if typeof(arg1) == "Vector2" then
        return {
            PaddingTop = UDim.new(0, arg1.Y),
            PaddingBottom = UDim.new(0, arg1.Y),
            PaddingLeft = UDim.new(0, arg1.X),
            PaddingRight = UDim.new(0, arg1.X)
        }
    end

    if typeof(arg1) == "UDim" then
        return { PaddingTop = arg1, PaddingBottom = arg1, PaddingLeft = arg1, PaddingRight = arg1 }
    end

    if typeof(arg1) ~= "UDim2" then
        return {}
    end

    return {
        PaddingTop = arg1.Y,
        PaddingBottom = arg1.Y,
        PaddingLeft = arg1.X,
        PaddingRight = arg1.X
    }
end

return React.memo(function(tbl1) -- name: Padding
    local padding = getPadding(tbl1.value)

    return React.createElement("UIPadding", {
        PaddingTop = padding.PaddingTop,
        PaddingBottom = padding.PaddingBottom,
        PaddingLeft = padding.PaddingLeft,
        PaddingRight = padding.PaddingRight,
        [React.Tag] = getTestIdTag(tbl1.testId)
    })
end)
