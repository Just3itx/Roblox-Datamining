-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T18:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local GuiObjectUtilsParent = script:FindFirstAncestor("GuiObjectUtils").Parent
local React = require(GuiObjectUtilsParent.React)

local function isGuiObjectSelected(tbl1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (tbl1.current == nil) and (GuiService.SelectedCoreObject == tbl1.current or GuiService.SelectedObject == tbl1.current)
end

local function useSelected(tbl1)
    local var1, var2 = React.useState(function(): boolean
        return isGuiObjectSelected(tbl1)
    end)

    React.useEffect(function()
        var2((isGuiObjectSelected(tbl1)))
    end, { tbl1 })

    React.useEffect(function()
        local tbl2 = {}
        local current = tbl1.current
        if current then
            local selectionGained = current.SelectionGained

            table.insert(tbl2, selectionGained:Connect(function()
                var2(true)
            end))

            local selectionLost = current.SelectionLost

            table.insert(tbl2, selectionLost:Connect(function()
                var2(false)
            end))
        end

        return function()
            for _, value in ipairs(tbl2) do
                value:Disconnect()
            end
        end
    end, { tbl1 })

    return var1
end

return useSelected
