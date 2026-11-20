-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)

local ShareGame = RobloxGui.Modules.Settings.Pages.ShareGame
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Constants = require(ShareGame.Constants)
local BackButton = require(ShareGame.Components.BackButton)
local SearchArea = require(ShareGame.Components.SearchArea)

local var1 = require(ShareGame.getTranslator)()

local var2 = Roact.PureComponent:extend("Header")

function var2.render(arg1)
    local deviceLayout = arg1.props.deviceLayout
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local closePage = arg1.props.closePage
    local searchAreaActive = arg1.props.searchAreaActive
    local analytics = arg1.props.analytics

    local toggleSearchIcon = arg1.props.toggleSearchIcon
    local iconType = arg1.props.iconType

    local var3 = Constants.LayoutSpecific[deviceLayout]
    local bool1 = deviceLayout == Constants.DeviceLayout.DESKTOP

    local var4 = toggleSearchIcon and searchAreaActive
    local var5 = if iconType == BackButton.IconType.None then var3.BACK_BUTTON_WIDTH else var3.BACK_BUTTON_MODAL_WIDTH
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = size,
        AnchorPoint = Vector2.new(0, 1),
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Position = UDim2.new(0, 0, 0, 4)
    }, {
        Title = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Visible = not var4,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Text = var1:FormatByKey("Feature.SettingsHub.Heading.InviteFriends"),
            TextSize = Theme.textSize(var3.PAGE_TITLE_TEXT_SIZE),
            TextColor3 = Constants.Color.WHITE,
            Font = Theme.font(Enum.Font.SourceSansSemibold, "Semibold"),
            ZIndex = zIndex
        }),
        BackButton = Roact.createElement(BackButton, {
            visible = true,
            iconType = iconType,
            position = UDim2.new(0, 0, 0.5, 0),
            size = UDim2.new(0, var5 or var3.BACK_BUTTON_WIDTH, 0, var3.BACK_BUTTON_HEIGHT),
            anchorPoint = Vector2.new(0, 0.5),
            zIndex = zIndex,
            onClick = closePage
        }),
        SearchArea = Roact.createElement(SearchArea, {
            fullWidthSearchBar = toggleSearchIcon or not bool1,
            searchBoxMargin = var3.SEARCH_BOX_MARGIN,
            anchorPoint = Vector2.new(1, 0.5),
            position = UDim2.new(1, 0, 0.5, 0),
            size = UDim2.new(1, -var5, 1, 0),
            zIndex = zIndex,
            analytics = analytics
        })
    })
end

return var2
