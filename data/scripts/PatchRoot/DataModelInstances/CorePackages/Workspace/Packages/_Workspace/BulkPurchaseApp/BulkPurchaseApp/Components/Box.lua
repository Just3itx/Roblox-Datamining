-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseAppParent = script:FindFirstAncestor("BulkPurchaseApp").Parent
local React = require(BulkPurchaseAppParent.React)

local function Box(tbl1)
    local var1 = not tbl1.children and {} or table.clone(tbl1.children)
    local var2 = table.clone(tbl1)
    var2.cornerRadius = nil
    var2.padding = nil
    var2.children = nil
    local padding = tbl1.padding
    local tbl2

    if typeof(padding) == "number" then
        tbl2 = {
            PaddingBottom = UDim.new(0, tbl1.padding),
            PaddingLeft = UDim.new(0, tbl1.padding),
            PaddingRight = UDim.new(0, tbl1.padding),
            PaddingTop = UDim.new(0, tbl1.padding)
        }
    else
        tbl2 = typeof(tbl1.padding) == "table"
            and {
                PaddingTop = UDim.new(0, if tbl1.padding and tbl1.padding[1] then tbl1.padding[1] else 0),
                PaddingRight = UDim.new(0, if tbl1.padding and tbl1.padding[2] then tbl1.padding[2] else 0),
                PaddingBottom = UDim.new(0, if tbl1.padding and tbl1.padding[3] then tbl1.padding[3] else 0),
                PaddingLeft = UDim.new(0, if tbl1.padding and tbl1.padding[4] then tbl1.padding[4] else 0)
            }
            or nil
    end

    if tbl2 then
        var1.Padding = React.createElement("UIPadding", tbl2)
    end
    if tbl1.cornerRadius then
        var1.Radius = React.createElement("UICorner", { CornerRadius = tbl1.cornerRadius })
    end

    return React.createElement("Frame", var2, var1)
end

return Box
