-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local getTestIdTag = require(Foundation.Utility.getTestIdTag)
local mapBindable = require(Foundation.Utility.mapBindable)

local _Types = require(Foundation.Components.Types)

local function toUDim(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if arg1 == nil then
        return nil
    end
    return mapBindable(arg1, function(arg2)
        if typeof(arg2) == "number" then
            return UDim.new(0, arg2)
        end
        return arg2
    end)
end

local function getCornerRadius(arg1)
    if ReactIs.isBinding(arg1) then
        return {
            TopLeftRadius = arg1,
            TopRightRadius = arg1,
            BottomRightRadius = arg1,
            BottomLeftRadius = arg1
        }
    end

    if typeof(arg1) == "number" then
        return {
            TopLeftRadius = UDim.new(0, arg1),
            TopRightRadius = UDim.new(0, arg1),
            BottomRightRadius = UDim.new(0, arg1),
            BottomLeftRadius = UDim.new(0, arg1)
        }
    end

    if typeof(arg1) == "UDim" then
        return {
            TopLeftRadius = arg1,
            TopRightRadius = arg1,
            BottomRightRadius = arg1,
            BottomLeftRadius = arg1
        }
    end

    if typeof(arg1) ~= "table" then
        return {}
    end

    return {
        TopLeftRadius = toUDim(arg1.topLeft),
        TopRightRadius = toUDim(arg1.topRight),
        BottomRightRadius = toUDim(arg1.bottomRight),
        BottomLeftRadius = toUDim(arg1.bottomLeft)
    }
end

return React.memo(function(tbl1) -- name: CornerRadius
    local cornerRadius = getCornerRadius(tbl1.value)

    return React.createElement("UICorner", {
        TopLeftRadius = cornerRadius.TopLeftRadius,
        TopRightRadius = cornerRadius.TopRightRadius,
        BottomRightRadius = cornerRadius.BottomRightRadius,
        BottomLeftRadius = cornerRadius.BottomLeftRadius,
        [React.Tag] = getTestIdTag(tbl1.testId)
    })
end)
