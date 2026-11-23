-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local React = require(script:FindFirstAncestor("BuildExperience").Parent.React)

local function useOnScreenKeyboardHeight()
    local function read(): number -- Luacid: Inlined by compiler; 2 call sites recovered
        return if UserInputService.OnScreenKeyboardVisible then UserInputService.OnScreenKeyboardSize.Y else 0
    end

    local var1, var2 = React.useState(read)

    React.useEffect(function()
        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            var2((read()))
        end

        local connection = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Connect(update)
        local connection2 = UserInputService:GetPropertyChangedSignal("OnScreenKeyboardSize"):Connect(update)
        update()

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    return var1
end

return useOnScreenKeyboardHeight
