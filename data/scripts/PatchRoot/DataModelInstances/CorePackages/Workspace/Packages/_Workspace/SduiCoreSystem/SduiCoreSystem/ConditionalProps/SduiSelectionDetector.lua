-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent

local React = require(SduiCoreSystemParent.React)

return React.memo(function(tbl1) -- name: SduiSelectionDetector
    local guiObject = tbl1.guiObject
    local setSelected = tbl1.setSelected

    React.useEffect(function()
        local tbl2 = {}
        if guiObject then
            local selectionGained = guiObject.SelectionGained

            table.insert(tbl2, selectionGained:Connect(function()
                setSelected(true)
            end))

            local selectionLost = guiObject.SelectionLost

            table.insert(tbl2, selectionLost:Connect(function()
                setSelected(false)
            end))
        end

        return function()
            for _, value in tbl2 do
                if value then
                    value:Disconnect()
                end
            end
        end
    end, { guiObject, setSelected })
end)
