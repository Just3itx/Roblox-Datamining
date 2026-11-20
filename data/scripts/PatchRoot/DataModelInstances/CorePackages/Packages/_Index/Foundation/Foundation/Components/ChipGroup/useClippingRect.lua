-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local React = require(FoundationParent.React)

local function useClippingRect(tbl1)
    local var1, var2 = React.useBinding(Rect.new(Vector2.zero, Vector2.zero))

    React.useEffect(function()
        if not tbl1.current then
            return
        end

        local var3 = nil
        local currentParent = tbl1.current.Parent
        while currentParent do
            if currentParent:IsA("GuiObject") and currentParent.ClipsDescendants then
                var3 = currentParent
                break
            end

            currentParent = currentParent.Parent
        end

        if not var3 then
            local layerCollector = tbl1.current:FindFirstAncestorWhichIsA("LayerCollector")
            var3 = layerCollector and layerCollector:IsA("GuiBase2d") and layerCollector or var3
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            if var3 then
                var2(Rect.new(var3.AbsolutePosition, var3.AbsolutePosition + var3.AbsoluteSize))
            end
        end

        local tbl2 = {}
        if var3 then
            local absolutePositionChanged = var3:GetPropertyChangedSignal("AbsolutePosition")
            table.insert(tbl2, absolutePositionChanged:Connect(update))
            local absoluteSizeChanged = var3:GetPropertyChangedSignal("AbsoluteSize")
            table.insert(tbl2, absoluteSizeChanged:Connect(update))
        end

        update()

        return function()
            for _, value in tbl2 do
                value:Disconnect()
            end
        end
    end, {})

    return var1
end

return useClippingRect
