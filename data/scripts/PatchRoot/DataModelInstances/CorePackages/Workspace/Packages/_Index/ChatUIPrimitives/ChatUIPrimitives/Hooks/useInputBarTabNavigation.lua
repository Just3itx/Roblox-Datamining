-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)

local chatTabNavigationSignal = require(ChatUIPrimitives.chatTabNavigationSignal)

local function withoutTabs(text: string) -- Luacid: Inlined by compiler; 5 call sites recovered
    return (string.gsub(text, "\t", ""))
end

local function stripTabs(current) -- Luacid: Inlined by compiler; 3 call sites recovered
    local currentText = current.Text
    local var1 = withoutTabs(currentText)

    if var1 == currentText then
        return
    end
    local cursorPosition = current.CursorPosition
    current.Text = var1

    if cursorPosition > 0 then
        local _, var2 = string.gsub(string.sub(currentText, 1, cursorPosition - 1), "\t", "")
        current.CursorPosition = cursorPosition - var2
    end
end

local function useInputBarTabNavigation(tbl1, arg1)
    local var1 = arg1 or UserInputService

    React.useEffect(function()
        local currentCurrent = nil
        local connection = nil

        local function watch(current) -- Luacid: Inlined by compiler; 1 call site recovered
            if currentCurrent == current then
                return
            end
            if connection then
                connection:Disconnect()
            end
            currentCurrent = current
            connection = current:GetPropertyChangedSignal("Text"):Connect(function()
                stripTabs(current)
            end)
        end

        local connection2 = var1.InputBegan:connect(function(input: InputObject)
            if input.UserInputType ~= Enum.UserInputType.Keyboard or input.KeyCode ~= Enum.KeyCode.Tab then
                return
            end

            local current = tbl1.current
            if current == nil or not current:IsFocused() then
                return
            end

            watch(current)
            local bool1 = withoutTabs(current.Text) == ""
            stripTabs(current)

            if bool1 then
                local isModifierKeyDown = input:IsModifierKeyDown(Enum.ModifierKey.Shift)
                chatTabNavigationSignal:fire(if isModifierKeyDown then -1 else 1)
            end
        end)

        return function()
            connection2:Disconnect()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl1, var1 })
end

return useInputBarTabNavigation
