-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystemParent = script:FindFirstAncestor("SduiCoreSystem").Parent

local React = require(SduiCoreSystemParent.React)
local Responsive = require(SduiCoreSystemParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore

return React.memo(function(tbl1) -- name: SduiHoverDetector
    local guiObject = tbl1.guiObject

    React.useEffect(function()
        local tbl2 = {}
        if guiObject then
            local mouseEnter = guiObject.MouseEnter

            table.insert(tbl2, mouseEnter:Connect(function()
                if GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Pointer then
                    tbl1.setHovered(true)
                end
            end))

            local mouseLeave = guiObject.MouseLeave

            table.insert(tbl2, mouseLeave:Connect(function()
                tbl1.setHovered(false)
            end))
        end

        return function()
            for _, value in tbl2 do
                if value then
                    value:Disconnect()
                end
            end
        end
    end, { guiObject })
end)
