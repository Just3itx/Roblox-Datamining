-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)
local getFirstFocusableDescendant = require(script.Parent.getFirstFocusableDescendant)

local function safeDisconnect(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1 then
        arg1:Disconnect()
    end
end

local function useFirstFocusableDescendantRef(arg1)
    local var1 = React.useRef(nil)

    React.useEffect(function()
        local connection = nil
        local connection2 = nil
        local connection3 = nil

        local function updateFirstFocusable(arg2)
            safeDisconnect(connection)
            safeDisconnect(connection3)
            local current = getFirstFocusableDescendant(arg2)
            if current then
                connection = current:GetPropertyChangedSignal("Selectable"):Connect(function()
                    updateFirstFocusable(arg2)
                end)

                connection3 = current.AncestryChanged:Connect(function()
                    updateFirstFocusable(arg2)
                end)
            end
            var1.current = current
        end

        if arg1 then
            updateFirstFocusable(arg1)
            connection2 = arg1.DescendantAdded:Connect(function()
                updateFirstFocusable(arg1)
            end)
        else
            var1.current = nil
        end

        return function()
            safeDisconnect(connection)
            safeDisconnect(connection2)
            safeDisconnect(connection3)
        end
    end, { arg1 })

    return var1
end

return useFirstFocusableDescendantRef
