-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:11:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _IconSize = require(Foundation.Enums.IconSize)
local _InputSize = require(Foundation.Enums.InputSize)
local _Types = require(Foundation.Components.Types)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local tbl1 = { tag = "text-align-x-left" }
local tbl2 = {
    container = { tag = "col size-full-0 auto-y" },
    content = { tag = "row align-y-top size-full-0 auto-y" },
    leading = { tag = "row align-y-top fill auto-y" },
    stack = { tag = "col fill auto-y" },
    message = tbl1,
    link = tbl1
}

local tbl3 = { tag = "size-full-0 auto-y" }
local tbl4 = {
    [false] = {
        message = { tag = "fill auto-y" },
        link = { tag = "auto-xy" },
        linkContainer = { tag = "auto-xy" }
    },
    [true] = {
        message = tbl3,
        link = {
            tag = tbl3.tag,
            padding = {}
        },
        linkContainer = tbl3
    }
}

local function useInternalNoticeVariantsProps(tbl5, bool1: boolean, bool2: boolean)
    local tbl6 = {
        tag = if bool2 then "text-truncate-end" else "text-wrap"
    }
    local tbl7 = {
        tag = tbl5.leading.gap
    }
    local stack = {
        tag = tbl5.stack.gap
    }
    local var1 = bool1 and { content = tbl7, stack = stack } or {
        content = {
            tag = tbl5.content.gap
        },
        leading = tbl7,
        stack = stack
    }

    return (composeStyleVariant(tbl2, tbl5, var1, tbl4[bool1], { message = tbl6, link = tbl6 }))
end

return useInternalNoticeVariantsProps
