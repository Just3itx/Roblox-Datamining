-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Flags = require(Foundation.Utility.Flags)
local Wrappers = require(Foundation.Utility.Wrappers)
local Connection = Wrappers.Connection
local Instance = Wrappers.Instance
local Signal = Wrappers.Signal

local function useClippingRect(tbl1)
    local var1, var2 = React.useBinding(Rect.new(Vector2.zero, Vector2.zero))

    local var3, var4 = React.useState(true)

    React.useEffect(function()
        local current = tbl1.current
        if not (current and current:IsA("GuiObject")) then
            return
        end

        local var5 = nil
        local currentParent = current.Parent
        while currentParent do
            if currentParent:IsA("GuiObject") and currentParent.ClipsDescendants then
                var5 = currentParent
                break
            end

            currentParent = currentParent.Parent
        end

        if Flags.FoundationUnifiedScrimScrolling then
            var4(var5 ~= nil)
        end

        if not var5 then
            if Flags.FoundationUnifiedScrimScrolling then
                var5 = current
            else
                local layerCollector = current:FindFirstAncestorWhichIsA("LayerCollector")
                var5 = layerCollector and layerCollector:IsA("GuiBase2d") and layerCollector or var5
            end
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            if var5 then
                local absolutePosition = current.AbsolutePosition
                var2(Rect.new(var5.AbsolutePosition - absolutePosition, var5.AbsolutePosition + var5.AbsoluteSize - absolutePosition))
            end
        end

        local tbl2 = { Signal.Connect(Instance.GetPropertyChangedSignal(current, "AbsolutePosition"), update) }

        if var5 then
            table.insert(tbl2, Signal.Connect(Instance.GetPropertyChangedSignal(var5, "AbsolutePosition"), update))

            table.insert(tbl2, Signal.Connect(Instance.GetPropertyChangedSignal(var5, "AbsoluteSize"), update))
        end

        update()

        return function()
            for _, value in tbl2 do
                Connection.Disconnect(value)
            end
        end
    end, {})

    return var1, var3
end

return useClippingRect
