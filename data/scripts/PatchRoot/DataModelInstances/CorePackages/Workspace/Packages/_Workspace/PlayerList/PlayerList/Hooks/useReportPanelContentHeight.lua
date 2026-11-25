-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local PanelContentHeightStore = require(scriptParentParent.Common.PanelContentHeightStore)

local function useReportPanelContentHeight(num1: number)
    local var1 = React.useRef(nil)

    return React.useCallback(function(arg1)
        if var1.current then
            var1.current:Disconnect()
            var1.current = nil
        end
        if arg1 == nil then
            return
        end

        local function report() -- Luacid: Inlined by compiler; 1 call site recovered
            local uiListLayout = arg1:FindFirstChildOfClass("UIListLayout")
            if uiListLayout then
                local absoluteContentSizeY = uiListLayout.AbsoluteContentSize.Y
                arg1.CanvasSize = UDim2.new(0, 0, 0, absoluteContentSizeY)
                PanelContentHeightStore.setBodyContentHeight(num1 + absoluteContentSizeY)
            end
        end

        local uiListLayout = arg1:FindFirstChildOfClass("UIListLayout")
        if uiListLayout then
            var1.current = uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(report)
        end

        report()
    end, { num1 })
end

return useReportPanelContentHeight
