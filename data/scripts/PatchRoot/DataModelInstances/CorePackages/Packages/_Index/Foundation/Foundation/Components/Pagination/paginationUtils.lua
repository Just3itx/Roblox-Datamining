-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local PaginationSize = require(Foundation.Enums.PaginationSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local tbl1 = {
    [PaginationSize.Small] = "row align-x-center align-y-center radius-circle size-600-600",
    [PaginationSize.Medium] = "row align-x-center align-y-center radius-circle size-800-800"
}

local tbl2 = {
    [PaginationSize.Small] = "text-label-small",
    [PaginationSize.Medium] = "text-label-medium"
}

return {
    getCircularSlotTag = function(arg1)
        return tbl1[arg1]
    end,
    getPageLabelTag = function(arg1): string
        return `auto-xy {tbl2[arg1]} content-default text-align-x-center text-align-y-center`
    end,
    getPageLabelTextTag = function(arg1): string
        return `auto-xy {tbl2[arg1]} text-align-x-center text-align-y-center`
    end,
    getSlotCursor = function(arg1)
        local borderWidth = math.floor(arg1.Stroke.Thicker)
        return {
            radius = UDim.new(0, arg1.Radius.Circle),
            offset = arg1.Size.Size_150,
            borderWidth = borderWidth
        }
    end,
    needsWidePageSlot = function(num1: number): boolean
        return num1 > 999
    end
}
