-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local Cryo = require(CorePackages.Packages.Cryo)
local React = require(CorePackages.Packages.React)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local UIBlox = require(CorePackages.Packages.UIBlox)

local InExperienceCapabilities = require(CorePackages.Workspace.Packages.InExperienceCapabilities).InExperienceCapabilities
local ReactFocusNavigation = require(CorePackages.Packages.ReactFocusNavigation)
local SharedFlags = CorePackages.Workspace.Packages.SharedFlags
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local _PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local useLayoutValues = PlayerList.Common.useLayoutValues
local useStyle = UIBlox.Core.Style.useStyle
local useFocusGuiObject = ReactFocusNavigation.useFocusGuiObject

local Foundation = require(CorePackages.Packages.Foundation)
local ControlState = Foundation.Enums.ControlState
local View = Foundation.View
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTokens = Foundation.Hooks.useTokens

local EntryFrameView = PlayerList.Presentation.EntryFrameView
local StatEntryContainer = require(scriptParentParentParent.Components.Container.StatEntryContainer)

local CellExtender = require(scriptParentParent.Presentation.CellExtender)
local PlayerIcon = require(scriptParent.PlayerIcon)
local PlayerNameTag = require(scriptParentParent.Presentation.PlayerNameTag)

local Constants = PlayerList.Common.Constants

local GetFFlagGateLeaderboardPlayerDropdownViaGUAC = require(SharedFlags).GetFFlagGateLeaderboardPlayerDropdownViaGUAC
local FFlagAddNewPlayerListFocusNav = PlayerList.Flags.FFlagAddNewPlayerListFocusNav
local FFlagAddNewPlayerListMobileFocusNav = PlayerList.Flags.FFlagAddNewPlayerListMobileFocusNav
local FFlagRemoveNewPlayerListOverlay = PlayerList.Flags.FFlagRemoveNewPlayerListOverlay
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagPlayerListFixLeaderstatsStacking = require(SharedFlags).FFlagPlayerListFixLeaderstatsStacking
local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook

local tbl1 = {
    Transparency = 1,
    Color = Color3.new(1, 1, 1)
}

local var1 = React.memo(function(tbl2) -- name: IconAndName
    return React.createElement(React.Fragment, {}, {
        Layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, tbl2.layoutValues.InitalPlayerEntryPadding)
        }),
        InitalPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, tbl2.layoutValues.InitalPlayerEntryPadding) }),
        PlayerIcon = React.createElement(PlayerIcon, {
            player = tbl2.player,
            playerIconInfo = tbl2.playerIconInfo,
            playerRelationship = tbl2.playerRelationship,
            layoutOrder = 1
        }),
        PlayerName = React.createElement(PlayerNameTag, {
            player = tbl2.player,
            isTitleEntry = tbl2.titlePlayerEntry,
            isHovered = tbl2.isHovered,
            textStyle = tbl2.textStyle,
            textFont = tbl2.playerNameFont,
            layoutOrder = 3
        })
    })
end)

local var2 = React.memo(function(tbl2) -- name: PlayerEntryChildren
    local isSmallTouchDevice = tbl2.isSmallTouchDevice or false
    local isDirectionalPreferred = tbl2.isDirectionalPreferred or false
    local layoutValues = tbl2.layoutValues
    local textStyle = tbl2.textStyle
    local playerNameFont = tbl2.playerNameFont
    local isHovered = tbl2.isHovered
    local backgroundStyle = tbl2.backgroundStyle
    local overlayStyle = tbl2.overlayStyle
    local isPressed = tbl2.isPressed
    local gameStats = tbl2.gameStats
    local playerStats = tbl2.playerStats
    local gameStatsCount = tbl2.gameStatsCount
    local playerStatsCount = tbl2.playerStatsCount

    local tbl3 = {}

    local tbl4 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center
    }

    if isDirectionalPreferred then
        tbl4.Padding = UDim.new(0, layoutValues.PlayerEntryPadding)
    end

    tbl3.Layout = React.createElement("UIListLayout", tbl4)

    local element = React.createElement(var1, {
        player = tbl2.player,
        playerIconInfo = tbl2.playerIconInfo,
        playerRelationship = tbl2.playerRelationship,
        titlePlayerEntry = tbl2.titlePlayerEntry,
        isHovered = isHovered,
        textStyle = textStyle,
        playerNameFont = playerNameFont,
        layoutValues = layoutValues
    })

    local tbl5 = { LayoutOrder = 0, BackgroundTransparency = 1 }

    if isSmallTouchDevice then
        tbl5.Size = UDim2.new(0, layoutValues.PlayerNameSizeXMobile, 0, layoutValues.PlayerEntrySizeY)
    else
        tbl5.Size = UDim2.new(0, tbl2.entrySizeX, 0, layoutValues.PlayerEntrySizeY)
    end

    tbl3.NameFrame = React.createElement("Frame", tbl5, element)

    if isDirectionalPreferred then
        tbl3.NameFrame = React.createElement("Frame", tbl5, {
            Shadow = React.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Image = layoutValues.ShadowImage,
                Position = UDim2.new(0, -layoutValues.ShadowSize, 0, 0),
                Size = UDim2.new(1, layoutValues.ShadowSize * 2, 1, layoutValues.ShadowSize),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = layoutValues.ShadowSliceRect,
                Visible = isDirectionalPreferred
            }),
            BackgroundFrame = React.createElement(EntryFrameView, tbl2.backgroundFrameProps, element)
        })
    end

    local maxLeaderstats = layoutValues.MaxLeaderstats
    local tbl6 = {
        isTeamEntry = false,
        showStatTitle = tbl2.titlePlayerEntry and isDirectionalPreferred,
        textStyle = textStyle
    }

    if isDirectionalPreferred then
        tbl6.backgroundStyle = backgroundStyle
        if not FFlagRemoveNewPlayerListOverlay then
            tbl6.overlayStyle = overlayStyle
            tbl6.doubleOverlay = isPressed
        end
    end

    if FFlagPlayerListFixLeaderstatsStacking then
        local var2 = SignalsReact.useSignalState(Signals.createComputed(function(arg1)
            if gameStats then
                return (gameStats.getAllData(arg1))
            end

            return {}
        end))

        local var3 = SignalsReact.useSignalState(Signals.createComputed(function(arg1)
            if playerStats then
                return (playerStats.getAllData(arg1))
            end

            return {}
        end))

        for statName, value2 in var2 do
            if maxLeaderstats < value2.order(false) then
                continue
            end

            local var4 = "GameStat_" .. statName
            local createElement = React.createElement
            local var5 = StatEntryContainer
            local join = Cryo.Dictionary.join
            local tbl7 = {
                statName = statName,
                stat = var3[statName]
            }
            tbl3[var4] = createElement(var5, join(tbl6, tbl7))
        end
    elseif gameStats and gameStatsCount and gameStatsCount > 0 and playerStats and playerStatsCount and playerStatsCount >= 0 then
        gameStats.iterateData(function(statName, arg1)
            if arg1.order(false) > maxLeaderstats then
                return
            end

            local stat = playerStats.getData(statName, false)
            tbl3["GameStat_" .. statName] = React.createElement(StatEntryContainer, Cryo.Dictionary.join(tbl6, { statName = statName, stat = stat }))
        end, false)
    end

    if not (FFlagRemoveNewPlayerListOverlay or isSmallTouchDevice or isDirectionalPreferred) then
        tbl3.BackgroundExtender = React.createElement(CellExtender, {
            layoutOrder = 100,
            size = UDim2.new(0, layoutValues.ExtraContainerPadding, 1, 0),
            backgroundStyle = {
                Color = Color3.new(1, 1, 1),
                Transparency = 1
            },
            overlayStyle = {
                Color = Color3.new(1, 1, 1),
                Transparency = 1
            },
            doubleOverlay = isPressed
        })
    end

    return React.createElement(React.Fragment, {}, tbl3)
end)
return React.memo(function(tbl2) -- name: PlayerEntryView
    local playerStatsCount = if FFlagPlayerListFixLeaderstatsStacking then nil else SignalsReact.useSignalState(tbl2.playerData.stats.getCount)

    local var4 = SignalsReact.useSignalBinding(Signals.createComputed(function(arg1)
        return tbl2.playerData.order(arg1) * 2 - 1
    end))

    local layoutOrder = React.useMemo(function()
        return if tbl2.layoutOrder then tbl2.layoutOrder else var4
    end, { tbl2.layoutOrder, var4 })

    local firstPlayerRef = React.useMemo(function()
        return if tbl2.playerData.order(false) == 1 then tbl2.firstPlayerRef else nil
    end, { tbl2.playerData.order, tbl2.firstPlayerRef })

    local isHovered, var8 = React.useState(false)
    local var9, var10 = React.useState(false)

    local var11 = React.useRef(nil)
    local var12 = if FFlagPlayerListUseFocusNavHook then nil else React.useRef(nil)
    local var13 = useFocusGuiObject()

    local var14 = ChromeEnabled()
    local layoutValues = useLayoutValues()
    local var16 = useStyle()
    local var17 = useTokens()
    local var18 = if tbl2.size then tbl2.size else UDim2.new(1, layoutValues.EntryXOffset, 0, layoutValues.PlayerEntrySizeY)
    local isSmallTouchDevice = tbl2.isSmallTouchDevice
    local isTenFoot = layoutValues.IsTenFoot
    local bool1 = tbl2.player == Players.LocalPlayer

    local onActivated = React.useCallback(function()
        if not (tbl2.openDropdown and tbl2.closeDropdown) then
            return
        end

        if tbl2.dropdownOpen and tbl2.selectedPlayer == tbl2.player then
            tbl2.closeDropdown()
            return
        end
        if FFlagPlayerListUseFocusNavHook and tbl2.setSelectedPlayerId then
            if tbl2.titlePlayerEntry then
                tbl2.setSelectedPlayerId(Constants.SELECTED_TITLE_PLAYER_ID)
            else
                tbl2.setSelectedPlayerId(tbl2.player.UserId)
            end
        end

        if GetFFlagGateLeaderboardPlayerDropdownViaGUAC() then
            if InExperienceCapabilities.canViewPlayerDropdownInLeaderboard then
                tbl2.openDropdown(tbl2.player)
                if var11.current then
                    local vector2 = Vector2.new(var11.current.AbsolutePosition.Y, var11.current.AbsoluteSize.Y)
                    if tbl2.setDropDownPlayerDimensionY then
                        tbl2.setDropDownPlayerDimensionY(vector2)
                    end
                end
            end
        else
            tbl2.openDropdown(tbl2.player)
            if var11.current then
                local vector2 = Vector2.new(var11.current.AbsolutePosition.Y, var11.current.AbsoluteSize.Y)
                if tbl2.setDropDownPlayerDimensionY then
                    tbl2.setDropDownPlayerDimensionY(vector2)
                end
            end
        end
    end, {
        tbl2.dropdownOpen,
        tbl2.selectedPlayer,
        tbl2.player,
        tbl2.openDropdown,
        tbl2.closeDropdown,
        tbl2.setDropDownPlayerDimensionY,
        tbl2.titlePlayerEntry,
        tbl2.setSelectedPlayerId,
        var11.current
    })

    local onStateChanged = React.useCallback(function(arg1)
        if arg1 == ControlState.Pressed or arg1 == ControlState.SelectedPressed then
            var10(true)
        elseif arg1 == ControlState.Hover or arg1 == ControlState.Selected then
            var8(true)
        elseif arg1 == ControlState.Default then
            var8(false)
            var10(false)
        end
    end, {})

    local var21 = React.useMemo(function()
        return {
            Color = if var14 then var16.Theme.BackgroundUIContrast.Color else var16.Theme.BackgroundContrast.Color,
            Transparency = 1
        }
    end, { var14, isTenFoot })

    local var22 = React.useMemo(function()
        return {
            Color = layoutValues.RowHoverColor,
            Transparency = 0.8
        }
    end, { layoutValues })

    local var23 = React.useMemo(function()
        return {
            Color = layoutValues.RowDefaultColor,
            Transparency = 0.8
        }
    end, { layoutValues })

    local var24 = React.useCallback(function()
        if isSmallTouchDevice then
            return (isHovered or var9) and var22 or var23
        end

        if not isTenFoot then
            return var21
        end

        local var24 = tbl2.dropdownOpen and tbl2.selectedPlayer == tbl2.player
        local var25 = isHovered

        if tbl2.titlePlayerEntry and layoutValues.BackgroundStyle then
            if var25 and layoutValues.BackgroundStyle.HoveredTitle then
                return layoutValues.BackgroundStyle.HoveredTitle
            end

            if layoutValues.BackgroundStyle.Title then
                return layoutValues.BackgroundStyle.Title
            end
        end

        if var24 and layoutValues.BackgroundStyle and layoutValues.BackgroundStyle.Selected then
            return layoutValues.BackgroundStyle.Selected or layoutValues.BackgroundStyle.Default
        end

        if var25 and layoutValues.BackgroundStyle and layoutValues.BackgroundStyle.Hovered then
            return layoutValues.BackgroundStyle.Hovered
        end

        if layoutValues.BackgroundStyle and layoutValues.BackgroundStyle.Default then
            return layoutValues.BackgroundStyle.Default
        end

        return var21
    end, {
        var21,
        isSmallTouchDevice,
        tbl2.dropdownOpen,
        tbl2.selectedPlayer,
        tbl2.player,
        tbl2.titlePlayerEntry,
        isHovered,
        var9
    })

    local var25 = React.useCallback(function()
        if isTenFoot then
            if isHovered then
                return layoutValues.HoveredTextStyle, layoutValues.PlayerNameTextSize
            end
            return layoutValues.DefaultTextStyle, layoutValues.PlayerNameTextSize
        elseif bool1 then
            return var16.Theme.TextEmphasis, layoutValues.PlayerNameTextSize
        else
            return var16.Theme.TextDefault, layoutValues.PlayerNameTextSize
        end
    end, {
        isHovered,
        bool1,
        isTenFoot,
        layoutValues,
        var16
    })

    local var26 = React.useCallback(function()
        if not isTenFoot then
            local var26 = tbl2.dropdownOpen and tbl2.selectedPlayer == tbl2.player
            if var9 then
                return var16.Theme.BackgroundOnPress
            end

            if var26 then
                return var16.Theme.BackgroundOnPress
            end

            if isHovered then
                return var16.Theme.BackgroundOnHover
            end
        end

        return tbl1
    end, {
        isHovered,
        var9,
        tbl2.dropdownOpen,
        tbl2.selectedPlayer,
        tbl2.player,
        var16,
        isTenFoot
    })

    local playerNameFont = React.useMemo(function()
        if isSmallTouchDevice then
            if bool1 then
                return {
                    Font = var16.Font.CaptionHeader.Font,
                    FontFace = normalizeFontFace(var17.Typography.CaptionMedium.Font),
                    Size = if FFlagEnableMobilePlayerListOnConsole then layoutValues.PlayerNameTextSize else var16.Font.CaptionHeader.RelativeSize * var16.Font.BaseSize,
                    MinSize = if FFlagEnableMobilePlayerListOnConsole then layoutValues.PlayerNameTextSize else var16.Font.Footer.RelativeMinSize * var16.Font.BaseSize
                }
            end
            return {
                Font = var16.Font.CaptionBody.Font,
                FontFace = normalizeFontFace(var17.Typography.BodySmall.Font),
                Size = if FFlagEnableMobilePlayerListOnConsole then layoutValues.PlayerNameTextSize else var16.Font.CaptionBody.RelativeSize * var16.Font.BaseSize,
                MinSize = if FFlagEnableMobilePlayerListOnConsole then layoutValues.PlayerNameTextSize else var16.Font.Footer.RelativeMinSize * var16.Font.BaseSize
            }
        end

        if isTenFoot then
            if tbl2.titlePlayerEntry then
                return {
                    Font = layoutValues.TitlePlayerEntryFont,
                    FontFace = normalizeFontFace(layoutValues.TitlePlayerEntryFont),
                    Size = layoutValues.PlayerNameTextSize,
                    MinSize = layoutValues.PlayerNameTextSize
                }
            end

            return {
                Font = layoutValues.PlayerEntryFont,
                FontFace = normalizeFontFace(layoutValues.PlayerEntryFont),
                Size = layoutValues.PlayerNameTextSize,
                MinSize = layoutValues.PlayerNameTextSize
            }
        end

        if bool1 then
            return {
                Font = var16.Font.CaptionHeader.Font,
                FontFace = normalizeFontFace(var17.Typography.CaptionMedium.Font),
                Size = var16.Font.CaptionHeader.RelativeSize * var16.Font.BaseSize,
                MinSize = var16.Font.Footer.RelativeMinSize * var16.Font.BaseSize
            }
        end

        return {
            Font = var16.Font.CaptionBody.Font,
            FontFace = normalizeFontFace(var17.Typography.BodySmall.Font),
            Size = var16.Font.CaptionBody.RelativeSize * var16.Font.BaseSize,
            MinSize = var16.Font.Footer.RelativeMinSize * var16.Font.BaseSize
        }
    end, {
        isSmallTouchDevice,
        isTenFoot,
        bool1,
        var16,
        layoutValues,
        var17
    })
    local backgroundStyle = var24()
    local textStyle = var25()
    local var30 = if FFlagRemoveNewPlayerListOverlay then nil else var26()

    local backgroundFrameProps = React.useMemo(function()
        return {
            size = UDim2.new(0, tbl2.entrySizeX, 0, layoutValues.PlayerEntrySizeY),
            isTeamFrame = false,
            backgroundStyle = backgroundStyle,
            overlayStyle = if FFlagRemoveNewPlayerListOverlay then nil else var30,
            doubleOverlay = if FFlagRemoveNewPlayerListOverlay then nil else var9,
            firstPlayerRef = firstPlayerRef,
            ref = if FFlagPlayerListUseFocusNavHook or not FFlagAddNewPlayerListFocusNav then nil else var12,
            onActivated = onActivated,
            onStateChanged = onStateChanged
        }
    end, {
        tbl2.entrySizeX,
        layoutValues.PlayerEntrySizeY,
        backgroundStyle,
        var30,
        var9,
        var12,
        onActivated,
        onStateChanged
    })

    local var32 = React.useMemo(function()
        return {
            isSmallTouchDevice = isSmallTouchDevice,
            isDirectionalPreferred = isTenFoot,
            layoutValues = layoutValues,
            textStyle = textStyle,
            playerNameFont = playerNameFont,
            isHovered = isHovered,
            backgroundStyle = backgroundStyle,
            overlayStyle = if FFlagRemoveNewPlayerListOverlay then nil else var30,
            isPressed = if FFlagRemoveNewPlayerListOverlay then nil else var9,
            player = tbl2.player,
            playerIconInfo = tbl2.playerIconInfo,
            playerRelationship = tbl2.playerRelationship,
            titlePlayerEntry = tbl2.titlePlayerEntry,
            entrySizeX = tbl2.entrySizeX,
            gameStats = tbl2.gameStats,
            playerStats = tbl2.playerData.stats,
            playerStatsCount = playerStatsCount,
            gameStatsCount = tbl2.gameStatsCount,
            backgroundFrameProps = backgroundFrameProps
        }
    end, {
        isSmallTouchDevice,
        isTenFoot,
        layoutValues,
        textStyle,
        playerNameFont,
        isHovered,
        backgroundStyle,
        var30,
        var9,
        tbl2.player,
        tbl2.playerIconInfo,
        tbl2.playerRelationship,
        tbl2.titlePlayerEntry,
        tbl2.entrySizeX,
        tbl2.playerData.stats,
        tbl2.gameStats,
        playerStatsCount,
        tbl2.gameStatsCount,
        backgroundFrameProps
    })

    if not FFlagPlayerListUseFocusNavHook then
        React.useEffect(function()
            local connection = nil
            local connection2 = nil

            if FFlagAddNewPlayerListFocusNav and var12.current and tbl2.prevFocusedEntry and tbl2.destroyedFocusedPlayerId then
                local current = var12.current

                connection = var12.current.SelectionLost:Connect(function()
                    tbl2.prevFocusedEntry.current = current
                end)

                connection2 = var12.current.Destroying:Connect(function()
                    connection:Disconnect()

                    if GuiService.SelectedCoreObject == current then
                        tbl2.destroyedFocusedPlayerId.current = tbl2.player.UserId
                        var13(nil)
                    end

                    connection2:Disconnect()
                end)
            end

            return function()
                if connection then
                    connection:Disconnect()
                end
            end
        end, {
            var13,
            tbl2.player,
            tbl2.prevFocusedEntry,
            tbl2.destroyedFocusedPlayerId,
            var12.current
        })
    end
    if FFlagPlayerListUseFocusNavHook then
        React.useEffect(function()
            return function()
                if tbl2.unregisterPlayerInstance then
                    tbl2.unregisterPlayerInstance(tbl2.player.UserId)
                end
            end
        end, { tbl2.unregisterPlayerInstance, tbl2.player })
    end

    local var33 = React.useCallback(function(current)
        if FFlagPlayerListUseFocusNavHook and tbl2.registerPlayerInstance then
            tbl2.registerPlayerInstance(tbl2.player.UserId, current, tbl2.playerData.order)
        end

        if not FFlagPlayerListUseFocusNavHook and FFlagAddNewPlayerListMobileFocusNav then
            var12.current = current
            return
        end
        var11.current = current
    end, { tbl2.player, tbl2.playerData, tbl2.registerPlayerInstance })

    if isSmallTouchDevice then
        return React.createElement(View, {
            Size = var18,
            BackgroundColor3 = backgroundStyle.Color,
            BackgroundTransparency = backgroundStyle.Transparency,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Image = "",
            LayoutOrder = layoutOrder,
            ref = var33,
            onActivated = onActivated,
            onStateChanged = onStateChanged
        }, {
            ChildrenFrame = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 1),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1
                },
                React.createElement(var2, var32)
            )
        })
    elseif isTenFoot then
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = var18,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            ref = 0
        }

        if not FFlagPlayerListUseFocusNavHook then
            var33 = var11
        end

        tbl3.ref = var33
        return createElement(str1, tbl3, React.createElement(var2, var32))
    else
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = var18,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            ref = 0
        }

        if not FFlagPlayerListUseFocusNavHook then
            var33 = var11
        end

        tbl3.ref = var33
        return createElement(str1, tbl3, {
            PlayerEntryContentFrame = React.createElement(
                EntryFrameView,
                Cryo.Dictionary.join(backgroundFrameProps, { size = UDim2.new(1, 0, 0, layoutValues.PlayerEntrySizeY) }),
                React.createElement(var2, var32)
            )
        })
    end
end)
