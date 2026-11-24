-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Config = require(ExpChat.Config)
local React = require(ExpChatParent.React)
local Dictionary = require(ExpChatParent.llama).Dictionary
local UIBlox = require(ExpChatParent.UIBlox)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local SharedFlags = require(ExpChatParent.SharedFlags)
local ChannelTabDisplayLabel = ExpChatShared.ChannelTabDisplayLabel
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local Interactable = UIBlox.Core.Control.Interactable
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor
local FFlagExpChatChannelTabSizingUpdate = require(ExpChat.Flags.FFlagExpChatChannelTabSizingUpdate)
local FFlagExpChatUseSharedChannelTabDisplayLabel = SharedFlags.FFlagExpChatUseSharedChannelTabDisplayLabel
local TextService = if FFlagExpChatChannelTabSizingUpdate then game:GetService("TextService") else nil
local Localization = require(ExpChat.Localization)
local getOtherDisplayNameInWhisperChannel = require(ExpChat.getOtherDisplayNameInWhisperChannel)
local getUnreadIndicatorLayout = require(script.Parent.getUnreadIndicatorLayout)
local useTabImpression = require(script.Parent.useTabImpression)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local unreachable = ExpChatShared.TabTypes.unreachable

local offset = if FFlagExpChatChannelTabSizingUpdate then 12 else 20

local white = Color3.fromRGB(255, 255, 255)

local tbl1 = {
    channelName = "",
    hasUnreadMessages = false,
    isDividerVisible = false,
    isTabCollapsed = false,
    isTabSelected = false,
    tabIndex = 1,
    isTabVisibleToUser = true,
    isLayoutReady = true,
    onTabSelected = nil,
    setTransparency = nil
}

local function createUnreadDot(uDim2: UDim2, backgroundTransparency: number)
    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(0, 8, 0, 8),
            Position = uDim2,
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundColor3 = Config.ChannelTabsSettings.UnreadDotColor3,
            BackgroundTransparency = backgroundTransparency,
            BorderSizePixel = 0
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }
    )
end

local function ChannelTab(tbl2)
    local var1 = Dictionary.join(tbl1, tbl2)
    useTabImpression({
        enabled = var1.isLayoutReady,
        name = var1.channelName,
        tabType = var1.tabType,
        index = var1.tabIndex,
        inOverflow = var1.isTabCollapsed,
        visible = var1.isTabVisibleToUser,
        hasUnreadMessages = var1.hasUnreadMessages,
        isSelected = if FFlagExpChatGlobalTabDefault then var1.isTabSelected else nil
    })

    local var2 = Localization.useLocalization(
        not FFlagExpChatUseSharedChannelTabDisplayLabel
            and {
                yourServer = "CoreScripts.TextChat.ChannelTabs.Here",
                moreServers = "CoreScripts.TextChat.ChannelTabs.Global2",
                friends = "CoreScripts.TextChat.ChannelTabs.Friends",
                system = "CoreScripts.TextChat.ChannelTabs.System",
                team = "CoreScripts.TextChat.ChannelTabs.Team"
            }
            or ChannelTabDisplayLabel.LocalizationKeys
    )

    local tabType = var1.tabType
    local channelName = var1.channelName
    if FFlagExpChatUseSharedChannelTabDisplayLabel then
        channelName = ChannelTabDisplayLabel.getDisplayLabel(tabType, var1.channelName, var1.textChannel, Players.LocalPlayer, var2)
    elseif tabType == "TextChat" then
        local channelName2 = var1.channelName
        if string.find(channelName2, "RBXGeneral") then
            channelName = var2.yourServer
        elseif string.find(channelName2, "RBXSystem") then
            channelName = var2.system
        elseif string.find(channelName2, "^RBXTeam") then
            channelName = var2.team
        elseif string.find(channelName2, "^RBXWhisper") and var1.textChannel and Players.LocalPlayer then
            channelName = getOtherDisplayNameInWhisperChannel(var1.textChannel, Players.LocalPlayer) or channelName
        end
    elseif tabType == "UniverseChat" then
        if string.find(var1.channelName, "RBXGlobal") then
            channelName = var2.moreServers
        end
    elseif tabType == "FriendsChat" then
        channelName = var2.friends
    else
        unreachable(tabType)
    end

    local var3, var4 = React.useState(var1.channelTabsSettings.BackgroundColor3)
    local selectionImageObject = useSelectionCursor(CursorKind.RoundedSlot)
    local var6 = FFlagExpChatChannelTabSizingUpdate and var1.hasUnreadMessages and not var1.isTabCollapsed

    local var7 = nil
    local var8 = nil
    local func1

    if FFlagExpChatChannelTabSizingUpdate then
        local naturalTextWidth, var10 = React.useBinding(nil)
        local tabWidth, var12 = React.useBinding(nil)
        func1 = function(arg1)
            var12(arg1.AbsoluteSize.X)
        end

        React.useEffect(function()
            var10(nil)
            if not var1.hasUnreadMessages or var1.isTabCollapsed then
                return
            end

            local bool1 = false
            task.spawn(function()
                local getTextBoundsParams = Instance.new("GetTextBoundsParams")
                getTextBoundsParams.Text = channelName
                getTextBoundsParams.Font = var1.channelTabsSettings.FontFace
                getTextBoundsParams.Size = var1.channelTabsSettings.TextSize
                getTextBoundsParams.Width = math.huge

                local success, result = pcall(function()
                    return TextService:GetTextBoundsAsync(getTextBoundsParams)
                end)
                if success and not bool1 then
                    var10(math.ceil(result.X))
                end
            end)

            return function()
                bool1 = true
            end
        end, {
            var1.channelTabsSettings.FontFace,
            var1.channelTabsSettings.TextSize,
            var1.hasUnreadMessages,
            var1.isTabCollapsed,
            channelName
        })

        if var6 then
            local var13 = React.joinBindings({ naturalTextWidth = naturalTextWidth, tabWidth = tabWidth }):map(function(arg1)
                return getUnreadIndicatorLayout(
                    var1.hasUnreadMessages,
                    var1.isTabCollapsed,
                    arg1.tabWidth,
                    arg1.naturalTextWidth,
                    offset,
                    8,
                    8
                )
            end)
            var7 = var13:map(function(arg1): UDim2
                if arg1 then
                    return UDim2.new(0, arg1.textWidth, 1, 0)
                end

                return UDim2.new(1, -(offset * 2 + 8 + 8), 1, 0)
            end)
            var8 = var13:map(function(arg1): UDim2
                if arg1 then
                    return UDim2.fromOffset(arg1.textLeft, 0)
                end

                return UDim2.fromOffset(offset + 8 + 8, 0)
            end)
        end
    else
        func1 = nil
    end

    local createElement = React.createElement
    local var9 = Interactable
    local tbl3 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = var1.isTabCollapsed and var1.setTransparency(var1.channelTabsSettings.BackgroundTransparency) or 1,
        BackgroundColor3 = var1.isTabCollapsed and var3 or var1.channelTabsSettings.BackgroundColor3,
        BorderSizePixel = 0,
        ref = var1.tabRef,
        SelectionImageObject = selectionImageObject,
        onStateChanged = function() end,
        [React.Change.AbsoluteSize] = func1,
        [React.Event.Activated] = var1.onTabSelected
    }

    tbl3[React.Event.MouseEnter] = function()
        if var1.isTabCollapsed then
            var4(var1.channelTabsSettings.HoverBackgroundColor3)
        end
    end
    tbl3[React.Event.MouseLeave] = function()
        if var1.isTabCollapsed then
            var4(var1.channelTabsSettings.BackgroundColor3)
        end
    end
    local tbl4 = {
        TextLabel = React.createElement("TextLabel", {
            Size = var7 or UDim2.fromScale(1, 1),
            Position = var8,
            BackgroundTransparency = 1,
            Text = channelName,
            FontFace = var1.channelTabsSettings.FontFace,
            TextSize = var1.channelTabsSettings.TextSize,
            TextColor3 = var1.isTabSelected and var1.channelTabsSettings.SelectedTabTextColor3 or var1.channelTabsSettings.TextColor3,
            TextTransparency = var1.setTransparency(0),
            TextStrokeColor3 = var1.channelTabsSettings.TextStrokeColor3,
            TextStrokeTransparency = var1.setTransparency(var1.channelTabsSettings.TextStrokeTransparency),
            TextXAlignment = if var6 then Enum.TextXAlignment.Left elseif var1.isTabCollapsed then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BorderSizePixel = 0
        }, {
            UIPadding = if var6 then nil else React.createElement(
                "UIPadding",
                {
                    PaddingLeft = UDim.new(0, offset + (if var1.isTabCollapsed then 4 else 0)),
                    PaddingRight = UDim.new(0, offset)
                }
            ),
            UnreadDot = var6 and createUnreadDot(UDim2.new(0, -8, 0.5, 0), var1.setTransparency(0))
        }),
        UnreadDot = var1.hasUnreadMessages and not var6 and createUnreadDot(UDim2.new(0, offset - 2, 0.5, 0), var1.setTransparency(0)),
        Highlight = var1.isTabSelected
            and React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 4),
                Position = UDim2.new(0, 0, 1, -4),
                BackgroundColor3 = white,
                BackgroundTransparency = var1.setTransparency(0),
                BorderSizePixel = 0
            }),
        Divider = var1.isDividerVisible
            and React.createElement("Frame", {
                AnchorPoint = var1.isTabCollapsed and Vector2.new(0, 1) or Vector2.new(0, 0.5),
                Position = var1.isTabCollapsed and UDim2.fromScale(0, 1) or UDim2.fromScale(1, 0.5),
                Size = var1.isTabCollapsed and UDim2.new(1, 0, 0, Config.ChannelTabsSettings.DividerSize)
                    or UDim2.new(0, Config.ChannelTabsSettings.DividerSize, 0.8, 0),
                BackgroundTransparency = var1.setTransparency(Config.ChannelTabsSettings.DividerTransparency),
                BackgroundColor3 = Config.ChannelTabsSettings.DividerColor3,
                BorderSizePixel = 0
            })
    }
    return createElement(var9, tbl3, tbl4)
end

return ChannelTab
