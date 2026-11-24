-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local useFocusGuiObject = require(FriendsChatParent.ReactFocusNavigation).useFocusGuiObject
local shouldFocusBackButtonOnKey = require(script.Parent.shouldFocusBackButtonOnKey)

local function useFocusBackButtonOnUp(tbl1, tbl2, arg1)
    local var1 = useFocusGuiObject()
    local var2 = arg1 or UserInputService

    React.useEffect(function()
        if tbl2 == nil then
            return
        end

        local connection = var2.InputBegan:Connect(function(input: InputObject)
            local current = tbl1.current
            local bool1 = not (current == nil) and var2:GetFocusedTextBox() == current
            local currentText = if current == nil then nil else current.Text

            if not shouldFocusBackButtonOnKey(input.KeyCode, bool1, currentText) then
                return
            end
            local current2 = tbl2.current
            if current2 == nil then
                return
            end
            if current ~= nil then
                current:ReleaseFocus()
            end
            var1(current2)
        end)
        return function()
            connection:Disconnect()
        end
    end, { tbl2, var2 })
end

return useFocusBackButtonOnUp
