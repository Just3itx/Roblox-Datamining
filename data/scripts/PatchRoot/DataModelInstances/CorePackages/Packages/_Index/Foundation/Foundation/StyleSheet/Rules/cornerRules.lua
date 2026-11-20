-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local CornerProperty = require(Foundation.Enums.CornerProperty)
local _Types = require(script.Parent.Types)

local uDim = UDim.new(0, 0)

local tbl1 = {
    CornerProperty.TopLeft,
    CornerProperty.TopRight,
    CornerProperty.BottomRight,
    CornerProperty.BottomLeft
}

local tbl2 = {
    ["top-left"] = CornerProperty.TopLeft,
    ["top-right"] = CornerProperty.TopRight,
    ["bottom-right"] = CornerProperty.BottomRight,
    ["bottom-left"] = CornerProperty.BottomLeft
}

local tbl3 = {
    top = { CornerProperty.TopLeft, CornerProperty.TopRight },
    bottom = { CornerProperty.BottomLeft, CornerProperty.BottomRight },
    left = { CornerProperty.TopLeft, CornerProperty.BottomLeft },
    right = { CornerProperty.TopRight, CornerProperty.BottomRight }
}

local function cornerProperties(arg1, tbl4) -- Luacid: Inlined by compiler; 6 call sites recovered
    local result = ({})
    for _, value in tbl4 do
        result[value] = arg1
    end
    return result
end

local function zeroedBaseline(tag: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        tag = tag,
        pseudo = "UICorner",
        priority = 0,
        properties = cornerProperties(uDim, tbl1)
    }
end

local function cornerRules(arg1, func1: (...any) -> (...any))
    local result = {}

    for _, value in arg1 do
        local var1 = func1(value)
        local cornerValue = var1.cornerValue
        local attributes = var1.attributes

        table.insert(result, {
            tag = `radius-{value.name}`,
            pseudo = "UICorner",
            priority = 1,
            properties = cornerProperties(cornerValue, tbl1),
            attributes = attributes
        })

        for value2, value3 in tbl3 do
            local tag = `radius-{value2}-{value.name}`
            local tbl4 = {
                tag = tag,
                pseudo = "UICorner",
                priority = 2,
                properties = cornerProperties(cornerValue, value3),
                attributes = attributes,
                children = { zeroedBaseline(tag) }
            }
            table.insert(result, tbl4)
        end

        for value2, value3 in tbl2 do
            local tag = `radius-{value2}-{value.name}`
            local tbl4 = {
                tag = tag,
                pseudo = "UICorner",
                priority = 3,
                properties = cornerProperties(cornerValue, { value3 }),
                attributes = attributes,
                children = { zeroedBaseline(tag) }
            }
            table.insert(result, tbl4)
        end
    end

    return result
end

return cornerRules
