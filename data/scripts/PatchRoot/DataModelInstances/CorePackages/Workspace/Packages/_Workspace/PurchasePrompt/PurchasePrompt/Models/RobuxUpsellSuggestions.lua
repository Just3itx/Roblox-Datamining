-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local RobuxUpsell = require(scriptParentParent.Models.RobuxUpsell)

local module = {}

function module.new(products)
    return { products = products }
end

function module.fromJson(tbl1)
    local tbl2 = ({})
    for k, product in pairs(tbl1.products) do
        tbl2[k] = RobuxUpsell.fromJson(product)
    end
    return module.new(tbl2)
end

return module
