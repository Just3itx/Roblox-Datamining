-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled
local Foundation = require(CorePackages.Packages.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useTokens = Foundation.Hooks.useTokens

local useLayoutValues = PlayerList.Common.useLayoutValues
local useStyle = UIBlox.Core.Style.useStyle

local EntryFrameView = PlayerList.Presentation.EntryFrameView
local StatEntryContainer = require(scriptParentParentParent.Components.Container.StatEntryContainer)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagPlayerListFixLeaderstatsStacking = SharedFlags.FFlagPlayerListFixLeaderstatsStacking
local FFlagFontFacePlayerList = SharedFlags.FFlagFontFacePlayerList
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole
local FFlagPlayerListContrastingTeamText = PlayerList.Flags.FFlagPlayerListContrastingTeamText
local getContrastingContentStyle = PlayerList.Common.getContrastingContentStyle

local CellExtender = require(scriptParentParent.Presentation.CellExtender)

return React.memo(function(tbl1) -- name: TeamEntryView
    local var1 = useLayoutValues()
    local var2 = useStyle()
    local var3 = if FFlagFontFacePlayerList or FFlagPlayerListContrastingTeamText then useTokens() else nil
    local isSmallTouchDevice = tbl1.isSmallTouchDevice or false
    local isDirectionalPreferred = tbl1.isDirectionalPreferred or false

    local textEmphasis = var2.Theme.TextEmphasis
    local var4 = if FFlagEnableMobilePlayerListOnConsole then var1.TeamNameTextSize else var2.Font.CaptionHeader.RelativeSize * var2.Font.BaseSize
    local var5 = if FFlagFontFacePlayerList then normalizeFontFace(var3.Typography.CaptionLarge.Font) else var2.Font.CaptionHeader.Font

    if isDirectionalPreferred then
        textEmphasis = var1.DefaultTextStyle
        var4 = var1.PlayerNameTextSize
        if FFlagFontFacePlayerList then
            var5 = normalizeFontFace(var1.TeamEntryFont)
        else
            var5 = var1.TeamEntryFont
        end
    end
    if FFlagPlayerListContrastingTeamText then
        local settings = var2.Settings
        local var6 = if isSmallTouchDevice then 0.5 elseif isDirectionalPreferred then if var1.BackgroundStyle then var1.BackgroundStyle.Default.Transparency else 0 else var1.TeamEntryBackgroundTransparency
        local color = if ChromeEnabled() then var2.Theme.BackgroundUIContrast.Color else var2.Theme.BackgroundContrast.Color
        local contrastingContentStyle = getContrastingContentStyle(
            tbl1.teamColor,
            var6,
            {
                Color3 = color,
                Transparency = (var1.OverrideBackgroundTransparency or 0) * settings.PreferredTransparency
            },
            var3.DarkMode.Content.Emphasis,
            var3.LightMode.Content.Emphasis
        )
        textEmphasis = {
            Color = contrastingContentStyle.Color3,
            Transparency = contrastingContentStyle.Transparency,
            StrokeColor = textEmphasis.StrokeColor,
            StrokeTransparency = textEmphasis.StrokeTransparency
        }
    end

    local backgroundStyle = React.useMemo(function()
        if isSmallTouchDevice then
            local settings = var2.Settings
            return {
                Color = tbl1.teamColor,
                Transparency = if FFlagPlayerListContrastingTeamText then 0.5 else settings.PreferredTransparency * 0.5
            }
        end

        if isDirectionalPreferred then
            return {
                Color = tbl1.teamColor,
                Transparency = if var1.BackgroundStyle then var1.BackgroundStyle.Default.Transparency else 0
            }
        end

        return {
            Color = tbl1.teamColor,
            Transparency = if FFlagPlayerListContrastingTeamText then var1.TeamEntryBackgroundTransparency else var1.TeamEntryBackgroundTransparency * var2.Settings.PreferredTransparency
        }
    end, {
        isSmallTouchDevice,
        isDirectionalPreferred,
        tbl1.teamColor,
        var2,
        var1
    })
    local overlayStyle = {
        Color = Color3.new(1, 1, 1),
        Transparency = 1
    }

    local maxLeaderstats = var1.MaxLeaderstats
    local var7 = if FFlagPlayerListFixLeaderstatsStacking then SignalsReact.useSignalState(tbl1.gameStats.getAllData) else nil

    if isSmallTouchDevice then
        local tbl3 = {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center
            })
        }
        local createElement = React.createElement
        local str1 = "TextLabel"
        local tbl4 = {
            Size = UDim2.new(0, var1.PlayerNameSizeXMobile, 1, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = if FFlagFontFacePlayerList then nil else var5,
            FontFace = 0,
            TextSize = 0,
            LayoutOrder = 0,
            TextColor3 = 0,
            TextStrokeTransparency = 0,
            TextStrokeColor3 = 0,
            BackgroundTransparency = 1,
            Text = 0,
            TextTruncate = 0
        }

        if not FFlagFontFacePlayerList then
            var5 = nil
        end

        tbl4.FontFace = var5
        tbl4.TextSize = var4

        tbl4.TextColor3 = textEmphasis.Color
        tbl4.TextStrokeTransparency = textEmphasis.StrokeTransparency
        tbl4.TextStrokeColor3 = textEmphasis.StrokeColor

        tbl4.Text = tbl1.teamName
        tbl4.TextTruncate = Enum.TextTruncate.AtEnd
        tbl3.NameFrame = createElement(
            str1,
            tbl4,
            {
                UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.TeamEntryTextPaddingMobile) })
            }
        )

        if FFlagPlayerListFixLeaderstatsStacking then
            for statName, value2 in var7 do
                if maxLeaderstats < value2.order(false) then
                    continue
                end

                local stat = tbl1.teamStats.getData(statName, false)
                tbl3["GameStat_" .. statName] = React.createElement(
                    StatEntryContainer,
                    {
                        statName = statName,
                        stat = stat,
                        isTeamEntry = true,
                        showStatTitle = false,
                        textStyle = textEmphasis
                    }
                )
            end
        elseif tbl1.gameStatsCount and tbl1.teamStatsCount and tbl1.gameStatsCount > 0 and tbl1.teamStatsCount >= 0 then
            tbl1.gameStats.iterateData(function(statName, arg1)
                if arg1.order(false) > maxLeaderstats then
                    return
                end

                local stat = tbl1.teamStats.getData(statName, false)
                tbl3["GameStat_" .. statName] = React.createElement(
                    StatEntryContainer,
                    {
                        statName = statName,
                        stat = stat,
                        isTeamEntry = true,
                        showStatTitle = false,
                        textStyle = textEmphasis
                    }
                )
            end, false)
        end

        return React.createElement("Frame", {
            LayoutOrder = tbl1.layoutOrder,
            Size = tbl1.size,
            BackgroundColor3 = backgroundStyle.Color,
            BackgroundTransparency = backgroundStyle.Transparency,
            BorderSizePixel = 0,
            GroupTransparency = nil
        }, tbl3)
    end

    local tbl3 = {}
    local padding = if isDirectionalPreferred then UDim.new(0, var1.PlayerEntryPadding) else nil
    tbl3.UIListLayout = React.createElement("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = padding
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl4 = {
        LayoutOrder = 0,
        Size = UDim2.new(0, tbl1.entrySizeX, 0, var1.TeamEntrySizeY),
        BackgroundTransparency = 1
    }
    local tbl5 = {
        Shadow = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = var1.ShadowImage,
            Position = UDim2.new(0, -var1.ShadowSize, 0, 0),
            Size = UDim2.new(1, var1.ShadowSize * 2, 1, var1.ShadowSize),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = var1.ShadowSliceRect,
            Visible = isDirectionalPreferred
        }),
        BGFrame = 0
    }

    local createElement2 = React.createElement
    local var9 = EntryFrameView
    local tbl6 = {
        size = UDim2.new(0, tbl1.entrySizeX, 0, var1.TeamEntrySizeY),
        isTeamFrame = true,
        backgroundStyle = backgroundStyle,
        overlayStyle = overlayStyle,
        doubleOverlay = false
    }
    local tbl7 = { TeamName = 0 }
    local createElement3 = React.createElement
    local str2 = "TextLabel"
    local tbl8 = {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = if FFlagFontFacePlayerList then nil else var5,
        FontFace = 0,
        TextSize = 0,
        TextColor3 = 0,
        TextStrokeTransparency = 0,
        TextStrokeColor3 = 0,
        BackgroundTransparency = 1,
        Text = 0,
        TextTruncate = 0
    }

    if not FFlagFontFacePlayerList then
        var5 = nil
    end

    tbl8.FontFace = var5
    tbl8.TextSize = var4
    tbl8.TextColor3 = textEmphasis.Color
    tbl8.TextStrokeTransparency = textEmphasis.StrokeTransparency
    tbl8.TextStrokeColor3 = textEmphasis.StrokeColor

    tbl8.Text = tbl1.teamName
    tbl8.TextTruncate = Enum.TextTruncate.AtEnd
    tbl7.TeamName = createElement3(
        str2,
        tbl8,
        { React.createElement("UIPadding", { PaddingLeft = UDim.new(0, var1.TeamEntryTextPadding) }) }
    )
    tbl5.BGFrame = createElement2(var9, tbl6, tbl7)
    tbl3.NameFrame = createElement(str1, tbl4, tbl5)

    if FFlagPlayerListFixLeaderstatsStacking then
        for statName, value2 in var7 do
            if maxLeaderstats < value2.order(false) then
                continue
            end

            local stat = tbl1.teamStats.getData(statName, false)
            tbl3["GameStat_" .. statName] = React.createElement(StatEntryContainer, {
                statName = statName,
                stat = stat,
                isTeamEntry = true,
                showStatTitle = false,
                backgroundStyle = backgroundStyle,
                overlayStyle = overlayStyle,
                doubleOverlay = false,
                textStyle = textEmphasis
            })
        end
    elseif tbl1.gameStatsCount and tbl1.teamStatsCount and tbl1.gameStatsCount > 0 and tbl1.teamStatsCount >= 0 then
        tbl1.gameStats.iterateData(function(statName, arg1)
            if arg1.order(false) > maxLeaderstats then
                return
            end

            local stat = tbl1.teamStats.getData(statName, false)
            tbl3["GameStat_" .. statName] = React.createElement(StatEntryContainer, {
                statName = statName,
                stat = stat,
                isTeamEntry = true,
                showStatTitle = false,
                backgroundStyle = backgroundStyle,
                overlayStyle = overlayStyle,
                doubleOverlay = false,
                textStyle = textEmphasis
            })
        end, false)
    end

    if not isDirectionalPreferred then
        tbl3.BackgroundExtender = React.createElement(CellExtender, {
            layoutOrder = 100,
            size = UDim2.new(0, var1.ExtraContainerPadding, 1, 0),
            backgroundStyle = backgroundStyle,
            overlayStyle = overlayStyle,
            doubleOverlay = false
        })
    end

    return React.createElement("Frame", {
        Size = tbl1.size,
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.layoutOrder,
        GroupTransparency = nil
    }, tbl3)
end)
