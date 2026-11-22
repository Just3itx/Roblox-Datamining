-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local isSplitPaneEducationalTourGuiObjectVisible = require(script.Parent.isSplitPaneEducationalTourGuiObjectVisible)

return function(arg1)
    local var1, var2 = React.useState(nil)

    React.useLayoutEffect(function()
        if arg1 == nil then
            var2(nil)
            return
        end

        local function updateRect()
            if not isSplitPaneEducationalTourGuiObjectVisible(arg1) then
                var2(nil)
                return
            end
            local absolutePosition = arg1.AbsolutePosition
            local absoluteSize = arg1.AbsoluteSize
            var2(
                Rect.new(
                    absolutePosition.X,
                    absolutePosition.Y,
                    absolutePosition.X + absoluteSize.X,
                    absolutePosition.Y + absoluteSize.Y
                )
            )
        end
        updateRect()
        local tbl1 = { arg1:GetPropertyChangedSignal("AbsolutePosition"):Connect(updateRect), arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateRect) }

        local var3 = arg1
        while var3 ~= nil do
            if var3:IsA("GuiObject") then
                tbl1[#tbl1 + 1] = var3:GetPropertyChangedSignal("Visible"):Connect(updateRect)
            end
            var3 = var3.Parent
        end

        return function()
            for _, value in tbl1 do
                value:Disconnect()
            end
        end
    end, { arg1 })

    return var1
end
