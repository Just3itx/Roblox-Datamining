-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local FocusNavigationContext = require(ChatUIPrimitivesParent.ReactFocusNavigation).FocusNavigationContext
local InputType = require(ChatUIPrimitivesParent.InputType)
local SharedFlags = require(ChatUIPrimitivesParent.SharedFlags)
local FFlagFriendsChatConversationListFocusNav = SharedFlags.FFlagFriendsChatConversationListFocusNav
local FFlagExpChatTabShortcutNav = SharedFlags.FFlagExpChatTabShortcutNav

local var1 = FFlagFriendsChatConversationListFocusNav or FFlagExpChatTabShortcutNav

local function useFocusInputBar(tbl1)
    local var2 = if var1 then React.useContext(FocusNavigationContext) else nil

    local var3 = React.useRef(nil)
    local ref = tbl1 or var3

    local var5 = React.useRef(false)

    local focus = React.useCallback(function()
        task.delay(0, function()
            local current = ref.current
            if current == nil then
                return
            end
            if var1 then
                if InputType.getInputGroup(UserInputService:GetLastInputType()) ~= InputType.InputTypeConstants.Gamepad then
                    GuiService.SelectedCoreObject = nil
                elseif var2 ~= nil then
                    var2:focusGuiObject(current, false)
                end
            end
            if not current:IsFocused() then
                var5.current = true
                current:CaptureFocus()
            end
        end)
    end, { ref, var2 })

    React.useEffect(function()
        return function()
            if not var5.current then
                return
            end
            local localPlayer = Players.LocalPlayer
            if not localPlayer then
                return
            end

            local textBox = Instance.new("TextBox")
            textBox.Visible = false
            textBox.Parent = localPlayer:FindFirstChildOfClass("PlayerGui")
            textBox:CaptureFocus()
            textBox:ReleaseFocus()
            textBox:Destroy()
        end
    end, {})

    return { ref = ref, focus = focus }
end

return useFocusInputBar
