-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(CorePackages.Packages.React)
local _Signals = require(CorePackages.Packages.Signals)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Otter = require(CorePackages.Packages.Otter)
local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local useLayoutValues = PlayerList.Common.useLayoutValues
local usePlayerListFocusNavigation = PlayerList.Hooks.usePlayerListFocusNavigation

local useStyle = UIBlox.Core.Style.useStyle
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject
local useFocusedGuiObject = ReactFocusNavigation.useFocusedGuiObject

local IconButton = UIBlox.App.Button.IconButton
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local iconSize = UIBlox.App.ImageSet.getIconSize(IconSize.Small)

local Images = UIBlox.App.ImageSet.Images

local PlayerEntryContainer = require(scriptParentParentParent.Components.Container.PlayerEntryContainer)
local TeamListContainer = require(scriptParentParentParent.Components.Container.TeamListContainer)
local TitleBarContainer = require(scriptParentParentParent.Components.Container.TitleBarContainer)

local PlayerDropDown = require(scriptParentParent.Presentation.PlayerDropDown)

local FFlagPlayerListFixMobileScrolling = require(scriptParentParentParent.Flags.FFlagPlayerListFixMobileScrolling)
local bool1 = game:DefineFastFlag("DisablePlayerListDisplayCloseBtn", false)
local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav
local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook
local FFlagPlayerListTwoTabsOnLegacy = PlayerList.Flags.FFlagPlayerListTwoTabsOnLegacy
local LegacyTwoTabsBody = PlayerList.Presentation.LegacyTwoTabsBody

local var1 = ChromeEnabled() and not bool1

local tbl1 = { dampingRatio = 1, frequency = 4 }

return React.memo(function(tbl2) -- name: PlayerListDisplayView
    local var2 = useLayoutValues()
    local var3 = useStyle()
    local backgroundTransparency = (var2.OverrideBackgroundTransparency or 0) * var3.Settings.PreferredTransparency

    local var5 = useFocusGuiObject()
    local var6 = if FFlagPlayerListUseFocusNavHook then nil else useFocusedGuiObject()
    local var7 = if FFlagPlayerListUseFocusNavHook then usePlayerListFocusNavigation() else nil
    local ref = React.useRef(nil)
    local var9 = React.useRef(nil)
    local var10 = if FFlagPlayerListUseFocusNavHook then nil else React.useRef(nil)
    local var11 = if FFlagPlayerListUseFocusNavHook then nil else React.useRef(nil)
    local var12 = React.useRef(Otter.createSingleMotor(0))

    local var13, var14 = React.useState(Vector2.new(0, 0))
    local var15, var16 = React.useState(100)
    local var17, var18 = React.useState(0)
    local contentsVisible, var20 = React.useState(true)

    local var21, setDropDownPlayerDimensionY = React.useState(Vector2.new(0, 0))

    local yOffset, var23 = React.useState(0)
    local var24, var25 = React.useState(0)

    local positionY, var27 = React.useState(0)
    local var28, var29 = React.useState(nil)

    local var30, var31 = React.createBinding(0)
    local var32, var33 = React.createBinding(0)
    local var34, var35 = React.createBinding(0)
    local var36 = React.joinBindings({ var30, var32, var34 }):map(function(tbl3)
        local var36 = tbl3[1]
        local var37 = tbl3[2]
        return var37 + (tbl3[3] - var37) * var36
    end)

    local var37 = React.useCallback(function(arg1)
        var25(arg1.AbsoluteSize.Y)
    end, {})

    local var38 = React.useCallback(function(arg1)
        var16(arg1.AbsoluteSize.Y)
    end, {})

    local var39 = React.useCallback(function(arg1)
        var14(arg1.CanvasPosition)
    end, {})

    local var40 = React.useCallback(function(arg1)
        var18(arg1.AbsolutePosition.Y)
    end, {})

    local var41 = React.useCallback(function(): boolean
        if not tbl2.isSmallTouchDevice then
            return false
        end

        local bool2 = not not (tbl2.teamList and tbl2.teamList.getCount(false) > 0)
        local bool3 = tbl2.gameStatsCount > 0

        return bool2 or bool3
    end, { tbl2.gameStatsCount, tbl2.isSmallTouchDevice, tbl2.teamList })

    React.useEffect(function()
        var12.current:onStep(var31)
        var12.current:onComplete(function(arg1)
            if arg1 == 0 then
                var20(true)
            end
        end)
    end, { var31 })

    React.useEffect(function()
        if tbl2.isSmallTouchDevice then
            var20(not tbl2.isMinimized)
            return
        end
        if var12.current then
            var12.current:setGoal(Otter.spring(if tbl2.isMinimized then 1 else 0, tbl1))
        end
        if tbl2.isMinimized then
            var20(false)
        end
    end, { tbl2.isSmallTouchDevice, tbl2.isMinimized, var12.current })

    React.useEffect(function()
        local var42 = var15 - 8
        if tbl2.gameStatsCount > 0 then
            var42 -= var2.TitleBarSizeY or 0
        end

        local num1 = math.min(var24, var42)
        var23(num1)
    end, {
        var15,
        var24,
        tbl2.gameStatsCount,
        var2.TitleBarSizeY
    })
    React.useEffect(function()
        local x = var21.X
        local y = var21.Y

        local current = ref.current

        if tbl2.isSmallTouchDevice or not current then
            var27(x)
            var29(nil)
            return
        end
        local var42 = x - current.AbsolutePosition.Y
        if var42 + y >= current.AbsoluteSize.Y then
            local var43 = var42 + y - current.AbsoluteSize.Y
            var27(var42 - var43)
            var29(Vector2.new(0, current.CanvasPosition.Y + var43))
            return
        end
        var27(var42)
        var29(nil)
    end, { var21, tbl2.isSmallTouchDevice, ref.current })

    if not FFlagPlayerListUseFocusNavHook then
        React.useEffect(function()
            if FFlagAddNewPlayerListFocusNav then
                return
            end

            if tbl2.isVisible then
                if tbl2.isDirectionalPreferred and tbl2.isUsingGamepad then
                    GuiService.SelectedCoreObject = var9.current
                    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
                end
                if ref.current and not tbl2.isSmallTouchDevice then
                    ref.current.SelectionGroup = true
                    ref.current.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
                    ref.current.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
                    ref.current.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
                    ref.current.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
                end
            else
                if tbl2.isDirectionalPreferred and tbl2.isUsingGamepad then
                    UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
                end

                if ref.current and GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(ref.current) then
                    GuiService.SelectedCoreObject = nil
                end
                if ref.current and not tbl2.isSmallTouchDevice then
                    ref.current.SelectionGroup = false
                end
            end
        end, {
            tbl2.isVisible,
            tbl2.isSmallTouchDevice,
            tbl2.isDirectionalPreferred,
            tbl2.isUsingGamepad,
            var9.current,
            ref.current
        })

        React.useEffect(function()
            if not FFlagAddNewPlayerListFocusNav or not tbl2.isVisible or not ref.current then
                return
            end

            if tbl2.isDirectionalPreferred and tbl2.isUsingGamepad then
                var5(nil)
                var5(ref.current)
                UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
            end
            if tbl2.isSmallTouchDevice then
                return
            end

            ref.current.SelectionGroup = true
            ref.current.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
            ref.current.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            ref.current.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
            ref.current.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        end, {
            var5,
            tbl2.isVisible,
            tbl2.isSmallTouchDevice,
            tbl2.isDirectionalPreferred,
            tbl2.isUsingGamepad,
            ref.current
        })

        React.useEffect(function()
            if not FFlagAddNewPlayerListMobileFocusNav
                or not tbl2.isVisible
                or not tbl2.isSmallTouchDevice
                or not tbl2.isUsingGamepad
                or not ref.current
            then
                return
            end
            local bool2 = false
            if tbl2.dropDownPlayer and not tbl2.dropDownVisible then
                local var42 = if LocalPlayer and tbl2.dropDownPlayer.UserId == LocalPlayer.UserId then ref.current:FindFirstChild("TitlePlayer", true) else ref.current:FindFirstChild("PlayerEntry_" .. tbl2.dropDownPlayer.UserId, true)

                if var42 and var42:IsA("GuiObject") then
                    var5(var42)
                    bool2 = true
                end
            end

            if not bool2 then
                var5(nil)
                var5(ref.current)
            end
        end, {
            var5,
            tbl2.isVisible,
            tbl2.dropDownVisible,
            tbl2.dropDownPlayer,
            tbl2.isSmallTouchDevice,
            tbl2.isUsingGamepad,
            ref.current
        })

        React.useEffect(function()
            if not FFlagAddNewPlayerListFocusNav or tbl2.isVisible or not ref.current then
                return
            end

            if (FFlagAddNewPlayerListMobileFocusNav and tbl2.isSmallTouchDevice or tbl2.isDirectionalPreferred) and tbl2.isUsingGamepad then
                UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
            end
            if var6 and var6:IsDescendantOf(ref.current) then
                var5(nil)
            end
            if FFlagAddNewPlayerListMobileFocusNav or not tbl2.isSmallTouchDevice then
                ref.current.SelectionGroup = false
            end
        end, {
            var6,
            var5,
            tbl2.isVisible,
            tbl2.isSmallTouchDevice,
            tbl2.isDirectionalPreferred,
            tbl2.isUsingGamepad,
            ref.current
        })

        React.useEffect(function()
            if not FFlagAddNewPlayerListFocusNav or not tbl2.isVisible or var6 or not var11.current or not ref.current then
                return
            end
            local var42 = ref.current:FindFirstChild("PlayerEntry_" .. var11.current, true)

            if var42 and var42:IsA("GuiObject") then
                var5(var42)
            elseif var10.current and var10.current:IsDescendantOf(ref.current) then
                var5(var10.current)
            else
                var5(ref.current)
            end

            var11.current = nil
        end, {
            var6,
            var5,
            tbl2.isVisible,
            var10.current,
            var11.current,
            ref.current
        })
    end

    if FFlagPlayerListUseFocusNavHook then
        React.useEffect(function()
            if tbl2.isVisible and tbl2.isSmallTouchDevice and tbl2.isUsingGamepad and not tbl2.dropDownVisible then
                var7.getFocus()
            end
        end, {
            var7,
            tbl2.isVisible,
            tbl2.isSmallTouchDevice,
            tbl2.isUsingGamepad,
            tbl2.dropDownVisible
        })

        React.useEffect(function()
            if not tbl2.isVisible then
                local isDescendantOf = ref.current and GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(ref.current)
                var7.cleanup(isDescendantOf)
            end
        end, { var7, tbl2.isVisible })
    end

    local var42 = if FFlagPlayerListUseFocusNavHook then React.useCallback(function(_: number, arg1, _)
        var7.setTitlePlayerInstance(arg1)
    end, { var7 }) else nil

    local var43 = if FFlagPlayerListUseFocusNavHook then React.useCallback(function(_: number)
        var7.setTitlePlayerInstance(nil)
    end, { var7 }) else nil

    local tbl3 = {}

    local createElement = React.createElement
    local str1 = "UIListLayout"
    local tbl4 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = if tbl2.isDirectionalPreferred then UDim.new(0, var2.EntryPadding) else nil
    }
    tbl3.UIListLayout = createElement(str1, tbl4)

    if LocalPlayer and tbl2.isSmallTouchDevice and var41() then
        local createElement2 = React.createElement
        local var44 = PlayerEntryContainer
        local tbl5 = {
            entrySizeX = tbl2.entrySizeX,
            layoutOrder = -3,
            titlePlayerEntry = true,
            player = LocalPlayer,
            playerIconInfo = tbl2.playerIconInfo[LocalPlayer.UserId] or { isPlaceOwner = false },
            playerRelationship = tbl2.playerRelationship[LocalPlayer.UserId]
                or {
                    isBlocked = false,
                    friendStatus = Enum.FriendStatus.NotFriend,
                    isFollowing = false,
                    isFollower = false
                },
            setDropDownPlayerDimensionY = setDropDownPlayerDimensionY,
            registerPlayerInstance = 0,
            unregisterPlayerInstance = 0,
            setSelectedPlayerId = 0
        }

        if not FFlagPlayerListUseFocusNavHook then
            var42 = nil
        end

        tbl5.registerPlayerInstance = var42
        if not FFlagPlayerListUseFocusNavHook then
            var43 = nil
        end

        tbl5.unregisterPlayerInstance = var43
        tbl5.setSelectedPlayerId = if FFlagPlayerListUseFocusNavHook then var7.setSelectedPlayerId else nil
        tbl3.TitlePlayer = createElement2(var44, tbl5)

        tbl3.BottomDiv = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.8,
            LayoutOrder = -2
        })
    end

    if tbl2.isSmallTouchDevice then
        tbl3.TitleBar = React.createElement(TitleBarContainer, {
            size = UDim2.new(1, 0, 0, var2.TitleBarSizeY),
            entrySizeX = tbl2.entrySizeX,
            layoutOrder = -1,
            contentsVisible = contentsVisible,
            isSmallTouchDevice = true
        })
    end

    if tbl2.teamListCount > 0 then
        local huge = math.huge
        tbl2.teamList.iterateData(function(teamId, teamData)
            local bool2

            if FFlagAddNewPlayerListFocusNav or not (teamData.order(false) <= huge and teamData.players.getCount(false) > 0) then
                bool2 = false
            else
                huge = teamData.order(false)
                bool2 = true
            end

            local tbl5 = tbl3
            local str2 = "TeamList_" .. tostring(teamId)
            local createElement2 = React.createElement
            local var44 = TeamListContainer
            local tbl6 = {
                entrySizeX = tbl2.entrySizeX,
                teamId = 0,
                teamData = 0,
                playerIconInfos = 0,
                playerRelationships = 0,
                firstPlayerRef = 0,
                setDropDownPlayerDimensionY = 0,
                prevFocusedEntry = 0,
                destroyedFocusedPlayerId = 0,
                registerTeamInstance = 0,
                unregisterTeamInstance = 0,
                setSelectedPlayerId = 0,
                isSmallTouchDevice = 0,
                isDirectionalPreferred = 0
            }

            if not FFlagPlayerListUseFocusNavHook then
                teamId = nil
            end

            tbl6.teamId = teamId
            tbl6.teamData = teamData
            tbl6.playerIconInfos = tbl2.playerIconInfo
            tbl6.playerRelationships = tbl2.playerRelationship
            tbl6.firstPlayerRef = if FFlagAddNewPlayerListFocusNav or not bool2 then nil else var9

            tbl6.setDropDownPlayerDimensionY = setDropDownPlayerDimensionY
            tbl6.prevFocusedEntry = if FFlagPlayerListUseFocusNavHook or not FFlagAddNewPlayerListFocusNav then nil else var10

            tbl6.destroyedFocusedPlayerId = if FFlagPlayerListUseFocusNavHook or not FFlagAddNewPlayerListFocusNav then nil else var11

            tbl6.registerTeamInstance = if FFlagPlayerListUseFocusNavHook then var7.registerTeamInstance else nil

            tbl6.unregisterTeamInstance = if FFlagPlayerListUseFocusNavHook then var7.unregisterTeamInstance else nil

            tbl6.setSelectedPlayerId = if FFlagPlayerListUseFocusNavHook then var7.setSelectedPlayerId else nil

            tbl6.isSmallTouchDevice = tbl2.isSmallTouchDevice
            tbl6.isDirectionalPreferred = tbl2.isDirectionalPreferred
            tbl5[str2] = createElement2(var44, tbl6)
        end, false)
    end

    if tbl2.isSmallTouchDevice then
        local scrollingEnabled = if FFlagPlayerListFixMobileScrolling then true else not tbl2.dropDownVisible

        local serverBody = React.createElement("ScrollingFrame", {
            Active = FFlagPlayerListFixMobileScrolling,
            Size = UDim2.fromScale(1, 1),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ScrollBarImageColor3 = var2.ScrollImageColor,
            ScrollBarImageTransparency = var2.ScrollImageTransparency,
            BorderSizePixel = 0,
            ScrollBarThickness = var2.ScrollBarSizeMobile,
            VerticalScrollBarInset = Enum.ScrollBarInset.None,
            HorizontalScrollBarInset = Enum.ScrollBarInset.None,
            ClipsDescendants = true,
            ScrollingEnabled = scrollingEnabled,
            ElasticBehavior = Enum.ElasticBehavior.Never,
            Selectable = false,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            SelectionGroup = if FFlagAddNewPlayerListMobileFocusNav then true else nil,
            SelectionBehaviorUp = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorDown = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorLeft = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            SelectionBehaviorRight = if FFlagAddNewPlayerListMobileFocusNav then Enum.SelectionBehavior.Stop else nil,
            ref = if FFlagAddNewPlayerListMobileFocusNav then ref else nil,
            [React.Change.CanvasPosition] = var39,
            [React.Change.AbsoluteSize] = var38
        }, tbl3)

        if not FFlagPlayerListTwoTabsOnLegacy then
            return serverBody
        end

        local color = if ChromeEnabled() then var3.Theme.BackgroundUIContrast.Color else var3.Theme.BackgroundContrast.Color
        return React.createElement("Frame", {
            Size = var2.PlayerScrollListSizeTwoTabsOnLegacy,
            BackgroundTransparency = 1
        }, {
            TwoTabsBody = React.createElement(LegacyTwoTabsBody, {
                serverBody = serverBody,
                isVisible = tbl2.isVisible,
                isDirectionalPreferred = tbl2.isDirectionalPreferred,
                backgroundColor = color,
                backgroundTransparency = backgroundTransparency
            })
        })
    end

    if tbl2.isDirectionalPreferred then
        local createElement2 = React.createElement
        local str2 = "ScrollingFrame"
        local tbl5 = {
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ScrollBarImageColor3 = var2.ScrollImageColor,
            ScrollBarImageTransparency = var2.ScrollImageTransparency,
            BorderSizePixel = 0,
            ScrollBarThickness = 6,
            VerticalScrollBarInset = Enum.ScrollBarInset.Always,
            ClipsDescendants = true,
            ScrollingEnabled = not tbl2.dropDownVisible,
            Selectable = false
        }

        if tbl2.dropDownVisible then
            var13 = var28 or var13
        end

        tbl5.CanvasPosition = var13
        tbl5.ref = ref

        tbl5[React.Change.CanvasPosition] = var39
        local serverBody = createElement2(str2, tbl5, tbl3)

        local createElement3 = React.createElement
        local str3 = "Frame"
        local tbl6 = {
            Position = var2.PlayerScrollListPosition,
            Size = var2.PlayerScrollListSize,
            BackgroundTransparency = 1,
            [React.Change.AbsoluteSize] = var38
        }
        local tbl7 = {
            TenFootScrollingFrame = if FFlagPlayerListTwoTabsOnLegacy then nil else serverBody,
            TwoTabsBody = if FFlagPlayerListTwoTabsOnLegacy then React.createElement(LegacyTwoTabsBody, {
                serverBody = serverBody,
                isVisible = tbl2.isVisible,
                isDirectionalPreferred = tbl2.isDirectionalPreferred,
                backgroundColor = if ChromeEnabled() then var3.Theme.BackgroundUIContrast.Color else var3.Theme.BackgroundContrast.Color,
                backgroundTransparency = backgroundTransparency
            }) else nil
        }
        return createElement3(str3, tbl6, tbl7)
    end

    local fadedBackgroundScaleDelta = var2.FadedBackgroundScaleDelta or 0
    local scrollBarOffset = var2.ScrollBarOffset or 0
    local scrollBarSize = var2.ScrollBarSize or 0
    local color = if ChromeEnabled() then var3.Theme.BackgroundUIContrast.Color else var3.Theme.BackgroundContrast.Color
    var33(backgroundTransparency)
    var35(var2.FadedBackgroundTransparency or 0)

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        LayoutOrder = 3,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, yOffset),
        BackgroundColor3 = color,
        BackgroundTransparency = var36,
        BorderSizePixel = 0,
        [React.Change.AbsolutePosition] = var40
    }
    local tbl6 = {
        PlayerDropDown = if contentsVisible then React.createElement(PlayerDropDown, {
            contentsVisible = contentsVisible,
            selectedPlayer = tbl2.dropDownPlayer,
            positionY = positionY,
            minPositionBoundY = -var17 + var2.DropDownScreenSidePadding,
            maxPositionBoundY = tbl2.screenSizeY - var17 - var2.DropDownScreenSidePadding
        }) else nil,
        ScrollingFrameClippingFrame = 0
    }

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl7 = {
        Visible = contentsVisible,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl8 = { ScrollingFrame = 0 }
    local createElement4 = React.createElement
    local str4 = "ScrollingFrame"
    local tbl9 = {
        Size = UDim2.new(1, -scrollBarOffset, 0, yOffset),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = var2.ScrollImageColor,
        ScrollBarImageTransparency = var2.ScrollImageTransparency,
        BorderSizePixel = 0,
        ScrollBarThickness = var2.ScrollBarSize,
        VerticalScrollBarInset = Enum.ScrollBarInset.Always,
        ClipsDescendants = false,
        ScrollingEnabled = not tbl2.dropDownVisible,
        Selectable = false
    }

    if tbl2.dropDownVisible then
        var13 = var28 or var13
    end

    tbl9.CanvasPosition = var13
    tbl9.ref = ref

    tbl9[React.Change.CanvasPosition] = var39
    local tbl10 = {
        OffsetUndoFrame = React.createElement("Frame", {
            Size = UDim2.new(1, scrollBarOffset + scrollBarSize, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            [React.Change.AbsoluteSize] = var37
        }, tbl3)
    }
    tbl8.ScrollingFrame = createElement4(str4, tbl9, tbl10)
    tbl6.ScrollingFrameClippingFrame = createElement3(str3, tbl7, tbl8)
    local serverBody = createElement2(str2, tbl5, tbl6)
    local titleBar = if tbl2.gameStatsCount > 0 then React.createElement(TitleBarContainer, {
        size = UDim2.new(1, 0, 0, var2.TitleBarSizeY),
        entrySizeX = tbl2.entrySizeX,
        layoutOrder = 2,
        contentsVisible = contentsVisible,
        showBackground = true,
        backgroundTransparency = var36
    }) else nil
    local createElement5 = React.createElement
    local str5 = "Frame"
    local tbl11 = {
        Position = var2.PlayerScrollListPosition,
        Size = var2.PlayerScrollListSize,
        BackgroundTransparency = 1,
        [React.Change.AbsoluteSize] = var38
    }
    local tbl12 = { SizeOffsetFrame = 0 }
    local createElement6 = React.createElement
    local str6 = "Frame"
    local tbl13 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }

    local tbl14 = {
        UIScale = React.createElement("UIScale", {
            Scale = var30:map(function(arg1)
                return 1 - fadedBackgroundScaleDelta * arg1
            end)
        }),
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Left
        }),
        TopRoundedRect = 0,
        TitleBar = 0,
        ScrollingFrameContainer = 0,
        TwoTabsBody = 0,
        BottomRoundedRect = 0
    }

    local element3

    if not var1 then
        element3 = React.createElement("ImageLabel", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/TopRoundedRect8px.png",
            ImageColor3 = color,
            ImageTransparency = var36,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 24, 18),
            SliceScale = 0.5,
            Size = UDim2.new(1, 0, 0, 4)
        })
    else
        element3 = React.createElement(
            "Frame",
            {
                LayoutOrder = 1,
                ClipsDescendants = true,
                Size = UDim2.new(1, 0, 0, iconSize + 2),
                BackgroundTransparency = 1
            },
            {
                DismissIconFrame = React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, (iconSize + 2) * 2),
                        BackgroundColor3 = color,
                        BackgroundTransparency = var36
                    },
                    {
                        DismissButton = React.createElement(IconButton, {
                            position = UDim2.new(0, 1, 0, 1),
                            iconSize = IconSize.Small,
                            icon = Images["icons/navigation/close"],
                            onActivated = tbl2.dismissPlayerList
                        }),
                        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 7) })
                    }
                )
            }
        )
    end

    tbl14.TopRoundedRect = element3

    tbl14.TitleBar = if FFlagPlayerListTwoTabsOnLegacy then nil else tbl2.gameStatsCount > 0
        and React.createElement(TitleBarContainer, {
            size = UDim2.new(1, 0, 0, var2.TitleBarSizeY),
            entrySizeX = tbl2.entrySizeX,
            layoutOrder = 2,
            contentsVisible = contentsVisible,
            showBackground = true,
            backgroundTransparency = var36
        })

    tbl14.ScrollingFrameContainer = if FFlagPlayerListTwoTabsOnLegacy then nil else serverBody

    tbl14.TwoTabsBody = if FFlagPlayerListTwoTabsOnLegacy then React.createElement(LegacyTwoTabsBody, {
        titleBar = titleBar,
        serverBody = serverBody,
        isVisible = tbl2.isVisible,
        isDirectionalPreferred = tbl2.isDirectionalPreferred,
        layoutOrder = 2,
        platformBodyHeight = yOffset + (tbl2.gameStatsCount > 0 and var2.TitleBarSizeY or 0),
        backgroundColor = color,
        backgroundTransparency = var36
    }) else nil
    local element4

    if not var1 then
        element4 = React.createElement("ImageLabel", {
            LayoutOrder = 4,
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/ui/BottomRoundedRect8px.png",
            ImageColor3 = color,
            ImageTransparency = var36,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(8, 8, 24, 16),
            SliceScale = 0.5,
            Size = UDim2.new(1, 0, 0, 4)
        })
    else
        element4 = React.createElement("Frame", {
            LayoutOrder = 4,
            ClipsDescendants = true,
            Size = UDim2.new(1, 0, 0, 7),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, { React.createElement("Frame", {
                Position = UDim2.new(0, 0, 0, -8),
                Size = UDim2.new(1, 0, 0, 14),
                BackgroundColor3 = color,
                BackgroundTransparency = var36,
                BorderSizePixel = 0
            }, { React.createElement("UICorner", { CornerRadius = UDim.new(0, 7) }) }) })
    end

    tbl14.BottomRoundedRect = element4
    tbl12.SizeOffsetFrame = createElement6(str6, tbl13, tbl14)
    return createElement5(str5, tbl11, tbl12)
end)
