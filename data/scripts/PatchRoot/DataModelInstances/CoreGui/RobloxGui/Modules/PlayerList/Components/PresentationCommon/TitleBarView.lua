-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)

local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local useLayoutValues = PlayerList.Common.useLayoutValues
local useStyle = UIBlox.Core.Style.useStyle

local FFlagPlayerListFixLeaderstatsStacking = require(CorePackages.Workspace.Packages.SharedFlags).FFlagPlayerListFixLeaderstatsStacking
local FFlagEnableMobilePlayerListOnConsole = PlayerList.Flags.FFlagEnableMobilePlayerListOnConsole

local tbl1 = {
    showDivider = false,
    showBackground = false,
    backgroundTransparency = 1,
    useCustomTextColor = false,
    customTextColor = Color3.fromRGB(255, 255, 255),
    headerPaddingLeft = 15
}

return React.memo(function(tbl2) -- name: TitleBarView
    local tbl3 = ({})
    for k, value in pairs(tbl1) do
        if tbl2[k] ~= nil then
            value = tbl2[k] or value
        end

        tbl3[k] = value
    end
    for k, value in pairs(tbl2) do
        tbl3[k] = value
    end

    local var1 = useLayoutValues()
    local var2 = useStyle()

    local tbl4 = {
        layout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center
        })
    }
    local entrySizeX = tbl3.entrySizeX
    if tbl3.isSmallTouchDevice then
        entrySizeX = var1.PlayerNameSizeXMobile
    end

    local textColor3 = tbl3.useCustomTextColor and tbl3.customTextColor or var2.Theme.TextMuted.Color

    local textTransparency = if tbl3.useCustomTextColor then 0 else var2.Theme.TextMuted.Transparency

    local createElement = React.createElement
    local str1 = "TextLabel"
    local tbl5 = {
        LayoutOrder = 1,
        Size = UDim2.new(0, entrySizeX, 1, 0),
        Text = RobloxTranslator:FormatByKey("InGame.PlayerList.Players"),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionSmall.Font),
        TextSize = if FFlagEnableMobilePlayerListOnConsole then var1.TitleBarTextSize else var2.Font.BaseSize * var2.Font.Footer.RelativeSize,
        TextTransparency = textTransparency,
        TextColor3 = textColor3
    }
    tbl4.playersHeader = createElement(
        str1,
        tbl5,
        {
            Padding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, tbl3.headerPaddingLeft) })
        }
    )

    local maxLeaderstats = var1.MaxLeaderstats

    if FFlagPlayerListFixLeaderstatsStacking then
        for value, value2 in (SignalsReact.useSignalState(tbl3.gameStats.getAllData)) do
            if maxLeaderstats < value2.order(false) then
                continue
            end

            local var5 = GameTranslator:TranslateGameText(CoreGui, value)

            local var6 = "stat_" .. value
            local createElement2 = React.createElement
            local str2 = "TextLabel"
            local tbl6 = {
                LayoutOrder = value2.order(false) + 1,
                Size = UDim2.new(0, var1.StatEntrySizeX, 1, 0),
                Text = var5,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionSmall.Font),
                TextSize = if FFlagEnableMobilePlayerListOnConsole then var1.TitleBarTextSize else var2.Font.BaseSize * var2.Font.Footer.RelativeSize,
                TextTransparency = textTransparency,
                TextColor3 = textColor3,
                TextTruncate = Enum.TextTruncate.AtEnd
            }
            tbl4[var6] = createElement2(str2, tbl6)
        end
    elseif tbl3.gameStatsCount and tbl3.gameStatsCount > 0 then
        tbl3.gameStats.iterateData(function(arg1, arg2)
            if arg2.order(false) > maxLeaderstats then
                return
            end

            local var5 = GameTranslator:TranslateGameText(CoreGui, arg1)

            local tbl6 = tbl4
            local var6 = "stat_" .. arg1
            tbl6[var6] = React.createElement("TextLabel", {
                LayoutOrder = arg2.order(false) + 1,
                Size = UDim2.new(0, var1.StatEntrySizeX, 1, 0),
                Text = var5,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                FontFace = normalizeFontFace(var2.Tokens.Typography.CaptionSmall.Font),
                TextSize = if FFlagEnableMobilePlayerListOnConsole then var1.TitleBarTextSize else var2.Font.BaseSize * var2.Font.Footer.RelativeSize,
                TextTransparency = textTransparency,
                TextColor3 = textColor3,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
        end, false)
    end

    local black = Color3.fromRGB(0, 0, 0)
    if tbl3.showBackground then
        if require(CorePackages.Workspace.Packages.Chrome).Enabled() then
            black = var2.Theme.BackgroundUIContrast.Color
        else
            black = var2.Theme.BackgroundContrast.Color
        end
    end
    local tbl6 = {}

    if tbl3.showDivider then
        tbl6.Divider = React.createElement("Frame", {
            Visible = tbl3.contentsVisible,
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = var2.Theme.Divider.Transparency,
            BackgroundColor3 = var2.Theme.Divider.Color,
            BorderSizePixel = 0
        })
    end

    tbl6.ChildrenFrame = React.createElement("Frame", {
        Visible = tbl3.contentsVisible,
        BackgroundTransparency = 1,
        Position = tbl3.showBackground and UDim2.new(0, 0, 0, -2) or UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0)
    }, tbl4)

    return React.createElement("Frame", {
        Size = tbl3.size,
        LayoutOrder = tbl3.layoutOrder,
        BackgroundTransparency = tbl3.backgroundTransparency,
        BackgroundColor3 = black,
        BorderSizePixel = 0
    }, tbl6)
end)
