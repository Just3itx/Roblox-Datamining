-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local UserInputService = require(Foundation.Utility.Wrappers.Services).UserInputService

local _InputPlatform = require(Foundation.Enums.InputPlatform)
local detectInputPlatform = require(script.Parent.detectInputPlatform)

local function useInputPlatform()
    local var1, var2 = React.useState(detectInputPlatform)

    React.useEffect(function()
        local function refresh() -- Luacid: Inlined by compiler; 1 call site recovered
            var2(detectInputPlatform())
        end

        local connection = UserInputService.GamepadConnected:Connect(refresh)
        local connection2 = UserInputService.GamepadDisconnected:Connect(refresh)
        refresh()

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    return var1
end

return useInputPlatform
