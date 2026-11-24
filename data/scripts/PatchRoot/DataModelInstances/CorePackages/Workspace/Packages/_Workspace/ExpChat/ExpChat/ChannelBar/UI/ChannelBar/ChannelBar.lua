-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Config = require(ExpChat.Config)
local React = require(ExpChatParent.React)
local ReactFocusNavigation = require(ExpChatParent.ReactFocusNavigation)
local SignalsReact = require(ExpChatParent.SignalsReact)
local createEffect = require(ExpChatParent.Signals).createEffect
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local Cryo = require(ExpChatParent.Cryo)
local UIBlox = require(ExpChatParent.UIBlox)

local Analytics = ExpChatShared.Analytics

local CursorKind = UIBlox.App.SelectionImage.CursorKind
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useSelectionCursor = UIBlox.App.SelectionImage.useSelectionCursor

local useInterpolatedClientSettings = require(ExpChat.ClientSettings.useInterpolatedClientSettings)
local var1 = require(ExpChat.Stores.GetFocusNavigationStore)(false)
local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore
local FFlagExpChatTabShortcutNav = require(ExpChatParent.SharedFlags).FFlagExpChatTabShortcutNav
local ExpChatPerfTracker = require(ExpChatParent.ChatUIPrimitives).Telemetry.ExpChatPerfTracker
local FFlagExpChatPerfTrackerTabName = require(ExpChatParent.ChatUIPrimitives).Flags.FFlagExpChatPerfTrackerTabName
local FFlagGlobalTextChatAddPlaySessionField = require(ExpChat.Flags.FFlagGlobalTextChatAddPlaySessionField)
local GetChatLayoutStore = require(ExpChat.Stores.GetChatLayoutStore)

local ChannelTab = require(script.Parent.Parent.ChannelTab)

local var2 = Cryo.List.join(
    Analytics.DefaultStandardizedFields,
    { "addPlaceInstanceId" },
    FFlagGlobalTextChatAddPlaySessionField and { "addPlaySessionId" } or {}
)

local iconsNavigationCycleDown = Images["icons/navigation/cycleDown"]
local white = Color3.fromRGB(255, 255, 255)

local darkStoneGrey = Color3.fromRGB(100, 100, 100)

local num1 = game:DefineFastInt("ExpChatTabNavFocusPollDelayFrames", 3)
local num2 = game:DefineFastInt("ExpChatTabNavFocusPollFrames", 4)

local function countAllChannelTabs(allChannelTabs): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num3 = 0
    for _ in pairs(allChannelTabs) do
        num3 += 1
    end
    return num3
end

local function setTransparency(arg1, transparencyValue) -- Luacid: Inlined by compiler; 9 call sites recovered
    return transparencyValue:map(function(arg2)
        if arg1 == nil then
            return 1
        end

        return arg1 + arg2 * (1 - arg1)
    end)
end

local function ChannelBar(tbl1)
    local num3 = countAllChannelTabs(tbl1.allChannelTabs)
    local y = Config.ChatWindowSize.Y.Scale * tbl1.chatWindowSettings.HeightScale * Config.ChatWindowMaxWidth

    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)

    local var7 = SignalsReact.useSignalState(GetChatLayoutStore(false).getChatWindowWidth)
    local var8, var9 = React.useState(1024)

    local isLayoutReady, var11 = React.useState(false)
    local var12 = var11

    local var13 = SignalsReact.useSignalState(var1.getChatInputBarFocused)
    local ref = React.useRef(nil)
    local var15 = ReactFocusNavigation.useFocusGuiObject()
    local selectionImageObject = useSelectionCursor(CursorKind.Invisible)
    local var10 = useSelectionCursor(CursorKind.RoundedSlot)

    local var18 = nil
    local var19

    if FFlagExpChatTabShortcutNav then
        local var20
        var20, var19 = React.useState(nil)
        var18 = var20
    else
        var19 = nil
    end

    local var20 = if FFlagExpChatTabShortcutNav then React.useRef({}) else nil
    local var21 = nil
    local var22 = nil
    if FFlagExpChatTabShortcutNav then
        var21, var22 = React.useState(nil)
    end

    local var23 = var7 or var8
    local bool1 = var23 < num3 * Config.ChannelTabsSettings.MinTabWidth
    local var24 = if bool1 or not num3 then math.floor((var23 - Config.ChannelTabsSettings.DropdownIconContainerWidth) / Config.ChannelTabsSettings.MinTabWidth) else num3
    local xOffset = (var23 - (bool1 and Config.ChannelTabsSettings.DropdownIconContainerWidth or 0)) / var24

    local yOffset = (num3 - var24) * 40

    React.useEffect(function()
        if FFlagExpChatTabShortcutNav then
            var1.setTabBarVisible(tbl1.visible)
            return function()
                var1.setTabBarVisible(false)
            end
        end
    end, { tbl1.visible })

    React.useEffect(function()
        if FFlagExpChatTabShortcutNav then
            var1.setTabBarRoot(var18)
            return function()
                var1.setTabBarRoot(nil)
            end
        end
    end, { var18 })

    local function somethingElseHoldsFocus(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return var1.getIsChatFocused() and not var1.getIsTabBarFocused() or UserInputService:GetFocusedTextBox() ~= nil
    end

    React.useEffect(function()
        if not FFlagExpChatTabShortcutNav then
            return
        end

        local bool2 = false

        local effect = createEffect(function(arg1)
            local tabNavFocusRequestTime = var1.getTabNavFocusRequestTime(arg1)
            local tabNavFocusTabName = var1.getTabNavFocusTabName(arg1)
            if tabNavFocusRequestTime == nil then
                return
            end

            local allChannelTab = if tabNavFocusTabName then tbl1.allChannelTabs[tabNavFocusTabName] else nil

            if allChannelTab == nil then
                var1.clearTabNavFocusRequest()
                return
            end

            local var25 = if FFlagExpChatUseChannelTabsStore then allChannelTab.tabIndex else allChannelTab.TabIndex
            var6(var24 < var25)

            local function superseded() -- Luacid: Inlined by compiler; 3 call sites recovered
                return bool2 or var1.getTabNavFocusRequestTime(false) ~= tabNavFocusRequestTime
            end

            task.spawn(function()
                for _ = 1, num1 do
                    RunService.Heartbeat:Wait()

                    if superseded() then
                        return
                    end
                end
                for i = 1, num2 do
                    if i > 1 then
                        RunService.Heartbeat:Wait()
                    end

                    if superseded() then
                        return
                    end

                    if not somethingElseHoldsFocus() then
                        var22(tabNavFocusTabName)
                        var1.clearTabNavFocusRequest()
                        return
                    end
                end

                if not superseded() then
                    var1.clearTabNavFocusRequest()
                end
            end)
        end)
        return function()
            bool2 = true
            effect()
        end
    end, { var24, tbl1.allChannelTabs })

    React.useEffect(function()
        if not FFlagExpChatTabShortcutNav or var21 == nil then
            return
        end

        if somethingElseHoldsFocus() then
            var22(nil)
            return
        end

        local var25 = var20.current[var21]
        if var25 then
            var15(var25)
            var22(nil)
        elseif tbl1.allChannelTabs[var21] == nil then
            var22(nil)
        end
    end, {
        var21,
        var5,
        tbl1.allChannelTabs,
        var15
    })
    local var25 = React.useMemo(function()
        for _, allChannelTab in pairs(tbl1.allChannelTabs) do
            local var25 = if FFlagExpChatUseChannelTabsStore then allChannelTab.tabIndex else allChannelTab.TabIndex

            if var24 < var25 and allChannelTab.HasUnreadMessages then
                return true
            end
        end
        return false
    end, { var24, tbl1.allChannelTabs })

    local tbl2 = ({})
    tbl2["$layout"] = React.createElement(
        "UIListLayout",
        {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal
        }
    )
    local tbl3 = ({})
    tbl3["$layout"] = React.createElement(
        "UIListLayout",
        {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        }
    )
    for k, allChannelTab in pairs(tbl1.allChannelTabs) do
        local var26 = if FFlagExpChatUseChannelTabsStore then allChannelTab.tabIndex else allChannelTab.TabIndex
        local isTabVisibleToUser = var26 <= var24
        local textChannel = tbl1.allTextChannels[k]
        local var27 = if FFlagExpChatUseChannelTabsStore then allChannelTab.type else allChannelTab.Type
        local createElement = React.createElement
        local var28 = ChannelTab

        local tbl4 = {
            channelTabsSettings = tbl1.channelTabsSettings,
            channelName = k,
            textChannel = textChannel,
            tabType = var27,
            hasUnreadMessages = allChannelTab.HasUnreadMessages,
            isDividerVisible = if var26 < var24 or bool1 then var26 < num3 else bool1,
            isTabCollapsed = not isTabVisibleToUser,
            isTabSelected = tbl1.selectedTabName and tbl1.selectedTabName == k,
            tabIndex = var26,
            isTabVisibleToUser = isTabVisibleToUser or var5,
            isLayoutReady = isLayoutReady,
            tabRef = FFlagExpChatTabShortcutNav and function(arg1)
                var20.current[k] = arg1
            end or nil,
            onTabSelected = 0,
            setTransparency = 0
        }

        function tbl4.onTabSelected()
            ExpChatPerfTracker.cancelAll()
            ExpChatPerfTracker.start(
                ExpChatPerfTracker.Events.ChatWindowTabSwitchTTI,
                { tabId = k },
                FFlagExpChatPerfTrackerTabName and { tabName = k } or nil
            )

            if not isTabVisibleToUser and var13 and ref.current then
                var15(ref.current)
            end
            Analytics:TelemetryLogEvent(Analytics.ExpChatTabClickedConfig, {
                name = k,
                type = var27 or "Unknown",
                index = var26,
                in_overflow = not isTabVisibleToUser,
                badge_count = if allChannelTab.HasUnreadMessages then 1 else 0,
                previous_tab_name = tbl1.selectedTabName
            }, var2)
            tbl1.onTabSelected(textChannel, not isTabVisibleToUser, k, var27)
            var6(false)
        end
        function tbl4.setTransparency(arg1)
            return setTransparency(arg1, tbl1.transparencyValue)
        end

        local channelTab = createElement(var28, tbl4)

        if isTabVisibleToUser then
            local createElement2 = React.createElement
            local tbl5 = {
                Size = UDim2.new(0, xOffset, 1, 0),
                BackgroundTransparency = 1,
                LayoutOrder = var26
            }
            tbl2[var26] = createElement2("Frame", tbl5, { ChannelTab = channelTab })
        else
            local layoutOrder = var26 - var24
            tbl3[layoutOrder] = React.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder
                },
                { ChannelTab = channelTab }
            )
        end
    end

    local channelTabsConfiguration = TextChatService:FindFirstChildOfClass("ChannelTabsConfiguration")
    local channelTabsSettings = tbl1.channelTabsSettings
    local backgroundTransparency = useInterpolatedClientSettings(channelTabsSettings).BackgroundTransparency
    local backgroundColor3 = useInterpolatedClientSettings(channelTabsSettings).BackgroundColor3

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 0, Config.ChannelTabsSettings.HorizontalBarHeight),
        BackgroundTransparency = 1,
        Visible = tbl1.visible,
        BorderSizePixel = 0,
        ZIndex = 3
    }

    if not FFlagExpChatTabShortcutNav then
        var19 = nil
    end

    tbl4.ref = var19
    tbl4[React.Event.MouseEnter] = tbl1.onHovered
    tbl4[React.Event.MouseLeave] = tbl1.onUnhovered
    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var9(arg1.AbsoluteSize.X)
        var12(true)
        if channelTabsConfiguration then
            channelTabsConfiguration:SetAbsoluteSize(arg1.AbsoluteSize)
        end
    end
    tbl4[React.Change.AbsolutePosition] = function(arg1)
        if channelTabsConfiguration then
            channelTabsConfiguration:SetAbsolutePosition(arg1.AbsolutePosition)
        end
    end

    local tbl5 = {
        HorizontalBar = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            },
            {
                ContentContainer = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.fromScale(1, 1),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ClipsDescendants = true
                    },
                    tbl2
                ),
                TopCorner = React.createElement("ImageLabel", {
                    BackgroundTransparency = 1,
                    ImageColor3 = backgroundColor3,
                    ImageTransparency = setTransparency(backgroundTransparency, tbl1.transparencyValue),
                    Image = "rbxasset://textures/ui/TopRoundedRect8px.png",
                    ScaleType = Enum.ScaleType.Slice,
                    Size = UDim2.new(1, 0, 0, 8),
                    SliceCenter = Rect.new(8, 8, 24, 32),
                    BorderSizePixel = 0,
                    Selectable = true,
                    SelectionImageObject = selectionImageObject,
                    ref = tbl1.topBorderRef
                }),
                BottomBorder = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 1, -1),
                    BackgroundColor3 = Config.ChannelTabsSettings.BorderColor3,
                    BackgroundTransparency = setTransparency(Config.ChannelTabsSettings.BorderTransparency, tbl1.transparencyValue),
                    BorderSizePixel = 0
                }),
                Background = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, Config.ChannelTabsSettings.HorizontalBarHeight - 8 - 1),
                    Position = UDim2.new(0, 0, 0, 8),
                    BackgroundColor3 = backgroundColor3,
                    BackgroundTransparency = setTransparency(backgroundTransparency, tbl1.transparencyValue),
                    BorderSizePixel = 0
                })
            }
        ),
        DropdownButton = 0,
        DropdownMenu = 0
    }
    local var26

    if bool1 then
        local createElement2 = React.createElement
        local tbl6 = {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, 0, 0, 8),
            Size = UDim2.new(0, Config.ChannelTabsSettings.DropdownIconContainerWidth, 1, -9),
            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl7 = { TextButton = 0, UnreadDot = 0 }
        local createElement3 = React.createElement
        local tbl8 = {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -Config.ChannelTabsSettings.DropdownIconPadding / 2, 0.5, -4),
            Size = UDim2.new(0, 27, 0, 27),
            BackgroundTransparency = setTransparency(if var3 then 0.3 else 1, tbl1.transparencyValue),
            BackgroundColor3 = darkStoneGrey,
            Text = "",
            BorderSizePixel = 0,
            Selectable = true,
            SelectionImageObject = var10,
            ref = ref
        }

        tbl8[React.Event.MouseEnter] = function()
            var4(true)
        end
        tbl8[React.Event.MouseLeave] = function()
            var4(false)
        end
        tbl8[React.Event.Activated] = function()
            var6(not var5)
        end

        tbl7.TextButton = createElement3("TextButton", tbl8, {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 27) }),
            DropdownIconImage = React.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(0.6, 0.6),
                BackgroundTransparency = 1,
                Image = iconsNavigationCycleDown,
                ImageColor3 = white,
                ImageTransparency = setTransparency(0, tbl1.transparencyValue),
                ScaleType = Enum.ScaleType.Stretch,
                BorderSizePixel = 0
            })
        })
        tbl7.UnreadDot = var25
            and React.createElement("Frame", {
                Size = UDim2.new(0, 8, 0, 8),
                Position = UDim2.new(0, 18, 0.5, -4),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = Config.ChannelTabsSettings.UnreadDotColor3,
                BackgroundTransparency = setTransparency(0, tbl1.transparencyValue),
                BorderSizePixel = 0
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
        var26 = createElement2("Frame", tbl6, tbl7)
    else
        var26 = bool1
    end

    tbl5.DropdownButton = var26
    tbl5.DropdownMenu = bool1
        and React.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -1, 0, Config.ChannelTabsSettings.HorizontalBarHeight + 1),
            Size = UDim2.new(0, 150, 0, yOffset),
            BackgroundTransparency = 1,
            Visible = var5
        }, {
            UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(150, y) }),
            Border = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = Config.ChannelTabsSettings.BorderColor3,
                Transparency = setTransparency(Config.ChannelTabsSettings.BorderTransparency, tbl1.transparencyValue)
            }),
            ScrollView = React.createElement("ScrollingFrame", {
                Size = UDim2.fromScale(1, 1),
                CanvasSize = UDim2.new(0, 150, 0, yOffset),
                BackgroundTransparency = setTransparency(0, tbl1.transparencyValue),
                ScrollBarThickness = 4,
                ScrollBarImageTransparency = setTransparency(0, tbl1.transparencyValue),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ElasticBehavior = Enum.ElasticBehavior.Always,
                ClipsDescendants = true,
                Selectable = false,
                BorderSizePixel = 0
            }, tbl3)
        })
    return createElement(str1, tbl4, tbl5)
end

return ChannelBar
