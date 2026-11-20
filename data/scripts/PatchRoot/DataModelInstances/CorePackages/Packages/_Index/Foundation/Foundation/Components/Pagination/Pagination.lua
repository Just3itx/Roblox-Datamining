-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:20:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local PaginationVariant = require(Foundation.Enums.PaginationVariant)

local withDefaults = require(Foundation.Utility.withDefaults)

local DirectionalPagination = require(script.Parent.Variants.DirectionalPagination)
local MultiPagePagination = require(script.Parent.Variants.MultiPagePagination)

local tbl1 = {
    variant = PaginationVariant.MultiPage,
    testId = "--foundation-pagination"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Pagination
    local var1 = withDefaults(arg1, tbl1)
    var1.ref = ref

    if var1.variant == PaginationVariant.MultiPage then
        return React.createElement(MultiPagePagination, var1)
    end
    return React.createElement(DirectionalPagination, var1)
end))
