-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local Constants = require(RobloxGui.Modules.Settings.Pages.ShareGame.Constants)

local var1 = Roact.Component:extend("SearchBox")

local ShareGameIcons = require(RobloxGui.Modules.Settings.Pages.ShareGame.Spritesheets.ShareGameIcons)
local Image = ShareGameIcons:GetImagePath()

local frame = ShareGameIcons:GetFrame("search_border")
local rect = Rect.new(3, 3, 4, 4)

local frame2 = ShareGameIcons:GetFrame("search_small")

local frame3 = ShareGameIcons:GetFrame("clear")

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local Theme = require(RobloxGui.Modules.Settings.Theme)
local var2 = require(ShareGame.getTranslator)()

function var1.init(arg1)
    arg1.state = { isTextWritten = false }

    arg1.searchField = nil
end

function var1.render(arg1)
    local anchorPoint = arg1.props.anchorPoint
    local onTextBoxFocusLost = arg1.props.onTextBoxFocusLost
    local onTextBoxFocused = arg1.props.onTextBoxFocused
    local position = arg1.props.position
    local searchFieldRef = arg1.props.searchFieldRef
    local size = arg1.props.size
    local visible = arg1.props.visible
    local zIndex = arg1.props.zIndex

    local isTextWritten = arg1.state.isTextWritten
    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        AnchorPoint = anchorPoint,
        Position = position,
        Size = size,
        Visible = visible,
        Image = Image,
        ImageRectOffset = frame.offset,
        ImageRectSize = frame.size,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = rect,
        ZIndex = zIndex
    }
    local tbl2 = {
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 6)
        }),
        SearchIcon = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Image = Image,
            ImageRectOffset = frame2.offset,
            ImageRectSize = frame2.size,
            Size = UDim2.new(0, 16, 0, 16),
            ZIndex = zIndex
        }),
        SearchField = 0,
        ClearButton = 0
    }
    local createElement2 = Roact.createElement
    local tbl3 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 28, 0.5, 0),
        Size = UDim2.new(1, -56, 1, 0),
        ClearTextOnFocus = false,
        PlaceholderColor3 = Constants.Color.GRAY3,
        PlaceholderText = var2:FormatByKey("Feature.SettingsHub.Label.SearchForFriendsPlaceholder.FriendsRename"),
        Text = "",
        TextColor3 = Constants.Color.WHITE,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = Theme.textSize(16),
        Font = Theme.font(Enum.Font.SourceSans),
        ZIndex = zIndex
    }

    tbl3[Roact.Ref] = function(searchField)
        arg1.searchField = searchField

        if searchFieldRef then
            searchFieldRef(searchField)
        end
    end
    tbl3[Roact.Event.Focused] = function()
        if onTextBoxFocused then
            onTextBoxFocused()
        end
    end
    tbl3[Roact.Event.FocusLost] = function(arg2)
        if onTextBoxFocusLost then
            onTextBoxFocusLost(arg2.Text)
        end
    end

    tbl2.SearchField = createElement2("TextBox", tbl3)

    local createElement3 = Roact.createElement
    local tbl4 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 16, 0, 16),
        Image = Image,
        ImageRectOffset = frame3.offset,
        ImageRectSize = frame3.size,
        ZIndex = zIndex,
        Visible = isTextWritten
    }

    tbl4[Roact.Event.Activated] = function()
        if arg1.searchField then
            arg1.searchField.Text = ""

            arg1.searchField:CaptureFocus()
        end
    end

    tbl2.ClearButton = createElement3("ImageButton", tbl4)
    return createElement("ImageLabel", tbl1, tbl2)
end

function var1.didMount(arg1)
    local searchField = arg1.searchField
    local onTextChanged = arg1.props.onTextChanged

    if not searchField then
        return
    end

    arg1.textBoxChangedConnection = searchField:GetPropertyChangedSignal("Text"):Connect(function()
        local searchFieldText = searchField.Text
        arg1:setState({ isTextWritten = searchFieldText:len() > 0 })

        onTextChanged(searchFieldText)
    end)
end

function var1.willUnmount(arg1)
    if arg1.textBoxChangedConnection then
        arg1.textBoxChangedConnection:Disconnect()
    end
end

return var1
