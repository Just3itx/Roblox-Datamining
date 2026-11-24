-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local UIBlox = require(ExpChatParent.UIBlox)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local useCursor = UIBlox.App.SelectionCursor.useCursor

local Config = require(ExpChat.Config)

local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

return function(arg1)
    local selectionImageObject = useCursor()
    local bool1 = (arg1.targetTextChannelDisplayName or "") ~= ""
    local var2 = GetFFlagTextChatEnableUniverseChatTabs() and not arg1.developerChannelTabsEnabled
    local var3 = bool1 and (not arg1.isChannelBarVisible or var2)

    return React.createElement("TextButton", {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        Font = Config.ChatInputBarFont,
        SelectionImageObject = selectionImageObject,
        Size = UDim2.fromScale(0, 1),
        Text = arg1.targetTextChannelDisplayName or "",
        TextColor3 = Config.ChatInputBarTextColor3,
        TextSize = Config.ChatInputBarTextSize,
        TextTransparency = arg1.transparency or 1,
        TextWrapped = true,
        Visible = var3,
        [React.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged,
        [React.Event.Activated] = arg1.onChannelChipActivated
    })
end
