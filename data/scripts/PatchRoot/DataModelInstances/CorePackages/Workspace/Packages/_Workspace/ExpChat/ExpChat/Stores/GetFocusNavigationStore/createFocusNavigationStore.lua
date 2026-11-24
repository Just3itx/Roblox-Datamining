-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local createSignal = require(ExpChatParent.Signals).createSignal
local isSelectionWithinVisible = require(script.Parent.isSelectionWithinVisible)
local chatFocusRequestSignal = require(ExpChat.ShortcutNav.chatFocusRequestSignal)
local FFlagExpChatGenericChatFocus = require(ExpChat.Flags.FFlagExpChatGenericChatFocus)

return function()
    local getChatInputBarFocused, var2 = createSignal(false)
    local getIsTabBarVisible, setTabBarVisible = createSignal(false)

    local getTabNavFocusRequestTime, var6 = createSignal(nil)

    local getTabNavFocusTabName, var8 = createSignal(nil)

    local getChatInputBarFocusRequestTime, var10 = createSignal(nil)

    local var11 = nil
    local var12 = nil
    return {
        getChatInputBarFocused = getChatInputBarFocused,
        getIsChatFocused = function()
            return isSelectionWithinVisible(GuiService.SelectedCoreObject, var11)
        end,
        getIsTabBarFocused = function()
            return isSelectionWithinVisible(GuiService.SelectedCoreObject, var12)
        end,
        getIsTabBarVisible = getIsTabBarVisible,
        getTabNavFocusRequestTime = getTabNavFocusRequestTime,
        getTabNavFocusTabName = getTabNavFocusTabName,
        getChatInputBarFocusRequestTime = getChatInputBarFocusRequestTime,
        focusChatInputBar = function()
            var2(true)
            if FFlagExpChatGenericChatFocus then
                chatFocusRequestSignal:fire()
            end
        end,
        unfocusChatInputBar = function()
            var2(false)
            if not FFlagExpChatGenericChatFocus then
                return
            end
            local textBox = UserInputService:GetFocusedTextBox()
            if textBox ~= nil and var11 ~= nil and textBox:IsDescendantOf(var11) then
                textBox:ReleaseFocus()
            end

            if GuiService.MenuIsOpen then
                GuiService:SetMenuIsOpen(false, "ExperienceChat")
            end
        end,
        setChatRoot = function(arg1)
            var11 = arg1
        end,
        setTabBarRoot = function(arg1)
            var12 = arg1
        end,
        setTabBarVisible = setTabBarVisible,
        requestTabNavFocus = function(str1: string, num1: number?)
            var8(str1)
            var6(num1 or os.clock())
        end,
        clearTabNavFocusRequest = function()
            var8(nil)
            var6(nil)
        end,
        requestChatInputBarFocus = function(num1: number?)
            var10(num1 or os.clock())
        end,
        clearChatInputBarFocusRequest = function()
            var10(nil)
        end
    }
end
