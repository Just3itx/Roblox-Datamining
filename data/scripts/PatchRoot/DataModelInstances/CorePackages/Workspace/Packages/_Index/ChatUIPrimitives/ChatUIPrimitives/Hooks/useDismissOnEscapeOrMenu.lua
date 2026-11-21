-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)

local function useDismissOnEscapeOrMenu(bool1: boolean, callback: (...any) -> (...any), arg1, arg2)
    local var1 = arg1 or UserInputService
    local var2 = arg2 or GuiService
    React.useEffect(function()
        if not bool1 then
            return
        end

        local bool2 = false
        local function dismissOnce() -- Luacid: Inlined by compiler; 1 call site recovered
            if bool2 then
                return
            end
            bool2 = true
            callback()
        end
        local connection = var1.InputBegan:Connect(function(input: InputObject)
            if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.ButtonB then
                dismissOnce()
            end
        end)

        local connection2 = var2.MenuOpened:Connect(dismissOnce)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {
        bool1,
        callback,
        var1,
        var2
    })
end
return useDismissOnEscapeOrMenu
