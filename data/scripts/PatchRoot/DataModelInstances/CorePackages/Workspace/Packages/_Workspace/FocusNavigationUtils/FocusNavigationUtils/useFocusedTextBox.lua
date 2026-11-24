-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)

return function(callback: ((...any) -> (...any))?, callback2: ((...any) -> (...any))?)
    local var1, var2 = React.useState(nil)
    React.useEffect(function()
        local connection = UserInputService.TextBoxFocused:Connect(function(textboxFocused: TextBox)
            var2(textboxFocused)
            if callback then
                callback(textboxFocused)
            end
        end)

        local connection2 = UserInputService.TextBoxFocusReleased:Connect(function(textboxReleased: TextBox)
            var2(nil)
            if callback2 then
                callback2(textboxReleased)
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var2 })

    return var1
end
