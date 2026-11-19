-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local React = require(FoundationParent.React)

local getHardwareSafeAreaInsets = require(script.Parent.getHardwareSafeAreaInsets)

local function useHardwareInsets(arg1)
    local var1, var2 = React.useState(getHardwareSafeAreaInsets)

    React.useEffect(function()
        local connection = if arg1 then arg1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            var2(function(arg2)
                local hardwareSafeAreaInsets = getHardwareSafeAreaInsets()

                return if hardwareSafeAreaInsets.bottom == arg2.bottom
                    and hardwareSafeAreaInsets.top == arg2.top
                    and hardwareSafeAreaInsets.left == arg2.left
                    and hardwareSafeAreaInsets.right == arg2.right then arg2 else hardwareSafeAreaInsets
            end)
        end) else nil

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { arg1 })

    return var1
end

return useHardwareInsets
