-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isOnScreen(arg1)
    if not arg1:IsDescendantOf(game) then
        return false
    end

    while arg1 ~= nil do
        if arg1:IsA("GuiObject") and not arg1.Visible then
            return false
        end

        if arg1:IsA("LayerCollector") and not arg1.Enabled then
            return false
        end
        arg1 = arg1.Parent
    end
    return true
end

local function observeGuiOnScreen(arg1, callback: (...any) -> (...any))
    local tbl1 = {}
    local var1 = nil
    local bool1 = false

    local function evaluate() -- Luacid: Inlined by compiler; 1 call site recovered
        if bool1 then
            return
        end
        local bool2 = isOnScreen(arg1)
        if bool2 ~= var1 then
            var1 = bool2
            callback(bool2)
        end
    end

    local function disconnectAncestors() -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in tbl1 do
            value:Disconnect()
        end
        table.clear(tbl1)
    end

    local function rewire()
        disconnectAncestors()
        local var2 = arg1
        while var2 ~= nil do
            if var2:IsA("GuiObject") then
                table.insert(tbl1, var2:GetPropertyChangedSignal("Visible"):Connect(evaluate))
            elseif var2:IsA("LayerCollector") then
                table.insert(tbl1, var2:GetPropertyChangedSignal("Enabled"):Connect(evaluate))
            end
            var2 = var2.Parent
        end

        evaluate()
    end

    local connection = arg1.AncestryChanged:Connect(rewire)
    rewire()

    return function()
        bool1 = true
        connection:Disconnect()
        disconnectAncestors()
    end
end

return observeGuiOnScreen
