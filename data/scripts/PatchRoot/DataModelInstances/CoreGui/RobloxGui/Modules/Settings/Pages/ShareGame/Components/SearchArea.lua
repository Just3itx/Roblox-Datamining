-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame

local GetFFlagShareGameSearchBoxFocusAnalytics = require(RobloxGui.Modules.Settings.Flags.GetFFlagShareGameSearchBoxFocusAnalytics)
local SearchBox = require(ShareGame.Components.SearchBox)
local IconButton = require(ShareGame.Components.IconButton)
local Constants = require(ShareGame.Constants)
local AppCommonLibText = require(CorePackages.Workspace.Packages.AppCommonLib).Text
local Theme = require(RobloxGui.Modules.Settings.Theme)

local SetSearchAreaActive = require(ShareGame.Actions.SetSearchAreaActive)
local SetSearchText = require(ShareGame.Actions.SetSearchText)
local ShareGameIcons = require(RobloxGui.Modules.Settings.Pages.ShareGame.Spritesheets.ShareGameIcons)

local var1 = require(ShareGame.getTranslator)()

local iconSpritePath = ShareGameIcons:GetImagePath()
local iconSpriteFrame = ShareGameIcons:GetFrame("search_large")

local Font = Theme.font(Enum.Font.SourceSans)
local GRAY3 = Constants.Color.GRAY3
local TextSize = Theme.textSize(20)

local var4 = Roact.PureComponent:extend("SearchArea")

function var4.init(arg1)
    arg1.state = {
        cancelText = var1:FormatByKey("Feature.SettingsHub.Action.CancelSearch")
    }
    arg1.searchField = nil
end

function var4.render(arg1)
    local fullWidthSearchBar = arg1.props.fullWidthSearchBar
    local searchBoxMargin = arg1.props.searchBoxMargin
    local anchorPoint = arg1.props.anchorPoint
    local position = arg1.props.position
    local zIndex = arg1.props.zIndex
    local searchAreaActive = arg1.props.searchAreaActive
    local size = arg1.props.size

    local cancelText = arg1.state.cancelText
    local textWidth = AppCommonLibText.GetTextWidth(cancelText, Font, TextSize)
    local var5 = searchBoxMargin + textWidth

    local setSearchText = arg1.props.setSearchText

    if not fullWidthSearchBar then
        return Roact.createElement(SearchBox, {
            anchorPoint = Vector2.new(1, 0.5),
            position = UDim2.new(1, 0, 0.5, 0),
            size = UDim2.new(0, 177, 0, 28),
            zIndex = zIndex,
            onTextChanged = setSearchText,
            searchFieldRef = function(searchField)
                arg1.searchField = searchField
            end
        })
    end

    local createElement = Roact.createElement

    local tbl1 = {
        SearchButton = Roact.createElement(IconButton, {
            visible = not searchAreaActive,
            anchorPoint = anchorPoint,
            position = position,
            size = UDim2.new(0, 44, 0, 44),
            zIndex = zIndex,
            iconHorizontalAlignment = Enum.HorizontalAlignment.Right,
            iconSpritePath = iconSpritePath,
            iconSpriteFrame = iconSpriteFrame,
            onClick = function(_)
                arg1.props.setSearchAreaActive(true)
            end
        }),
        SearchBox = Roact.createElement(SearchBox, {
            anchorPoint = Vector2.new(0, 0.5),
            position = UDim2.new(0, 0, 0.5, 0),
            size = UDim2.new(1, -var5, 0, 28),
            zIndex = zIndex,
            visible = searchAreaActive,
            modalFocused = searchAreaActive,
            onTextChanged = setSearchText,
            onTextBoxFocused = function()
                if GetFFlagShareGameSearchBoxFocusAnalytics() and arg1.props.analytics then
                    arg1.props.analytics:onSearchFocused()
                end
            end,
            onTextBoxFocusLost = function(arg2)
                if arg2 == "" then
                    arg1.props.setSearchAreaActive(false)
                end
            end,
            searchFieldRef = function(searchField)
                arg1.searchField = searchField
            end
        }),
        Cancel = 0
    }

    local createElement2 = Roact.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, textWidth, 1, 0),
        TextSize = TextSize,
        TextColor3 = GRAY3,
        Font = Font,
        ZIndex = zIndex,
        Visible = searchAreaActive
    }
    tbl2[Roact.Ref] = function(arg2)
        if not arg2 then
            return
        end
        arg2.Text = cancelText

        if arg1.textConnection then
            return
        end

        local textChanged = arg2:GetPropertyChangedSignal("Text")

        arg1.textConnection = textChanged:connect(function()
            arg1:setState({ cancelText = arg2.Text })
        end)
    end

    tbl2[Roact.Event.Activated] = function(_)
        arg1.props.setSearchAreaActive(false)
    end

    tbl1.Cancel = createElement2("TextButton", tbl2)
    return createElement(
        "Frame",
        {
            AnchorPoint = anchorPoint,
            Position = position,
            Size = size,
            BackgroundTransparency = 1,
            ZIndex = zIndex
        },
        tbl1
    )
end

function var4.didUpdate(arg1, arg2)
    local fullWidthSearchBar = arg1.props.fullWidthSearchBar

    if not arg1.searchField then
        return
    end
    if not arg1.props.isPageOpen and arg2.isPageOpen then
        spawn(function()
            if fullWidthSearchBar then
                arg1.props.setSearchAreaActive(false)
                return
            end
            arg1.searchField.Text = ""
        end)
    end

    if not fullWidthSearchBar then
        return
    end

    local searchAreaActive = arg1.props.searchAreaActive
    local searchAreaActive2 = arg2.searchAreaActive

    if searchAreaActive and not searchAreaActive2 then
        arg1.searchField:CaptureFocus()
    elseif not searchAreaActive and searchAreaActive2 then
        arg1.searchField.Text = ""
    end
end

return (RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isPageOpen = arg1.Page.IsOpen,
        searchAreaActive = arg1.ConversationsSearch.SearchAreaActive
    }
end, function(callback)
    return {
        setSearchAreaActive = function(arg1)
            callback(SetSearchAreaActive(arg1))
        end,
        setSearchText = function(arg1)
            callback(SetSearchText(arg1))
        end
    }
end)(var4))
