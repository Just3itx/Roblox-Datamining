-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local Cryo = require(GameCollectionsParent.Cryo)
local React = require(GameCollectionsParent.React)

return function(tbl1, num1: number?, num2: number?)
    return React.useMemo(function()
        local tbl2 = {}
        local bool1 = false

        for _, value in tbl1 do
            local spanOverride = value.spanOverride
            if not spanOverride then
                table.insert(tbl2, value)
            else
                local colSpan = spanOverride.colSpan or 1
                local rowSpan = spanOverride.rowSpan or 1
                table.insert(
                    tbl2,
                    Cryo.Dictionary.join(
                        value,
                        {
                            sizeOverride = UDim2.new(colSpan, (num1 or 0) * (colSpan - 1), rowSpan, (num2 or 0) * (rowSpan - 1))
                        }
                    )
                )
                bool1 = true
            end
        end

        return if bool1 then tbl2 else tbl1
    end, { tbl1, num1, num2 })
end
