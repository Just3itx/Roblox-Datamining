-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent

local dependencies = require(FriendsLanding.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local Cryo = require(FriendsLandingParent.Cryo)
local useDesignTokens = require(FriendsLandingParent.Style).useDesignTokens

local var1 = Roact.PureComponent:extend("ShowMoreButton")

local function func1() end

var1.defaultProps = {
    layoutOrder = 1,
    onSizeChange = func1,
    onActivated = func1,
    buttonHeight = 48
}

var1.MAX_WIDTH = 640

function var1.init(arg1)
    arg1.state = { width = 100 }

    arg1.localization = { showMore = "Feature.Friends.Action.ShowMore" }

    function arg1.onChangeSize(arg2)
        local var2 = arg1.props.maxWidth or var1.MAX_WIDTH
        arg1:setState({ width = math.min(var2, arg2.AbsoluteSize.X) })

        arg1.props.onSizeChange(arg2)
    end
end

function var1.render(arg1)
    return withLocalization(arg1.localization)(function(arg2)
        local buttonHeight = arg1.props.buttonHeight
        local uDim2 = UDim2.new(0, arg1.state.width, 0, buttonHeight)

        local createFragment = Roact.createFragment
        local tbl1 = {
            showMoreContainer = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                LayoutOrder = arg1.props.layoutOrder,
                Size = UDim2.new(1, 0, 0, buttonHeight + 48),
                [Roact.Change.AbsoluteSize] = arg1.onChangeSize
            }, {
                layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                showMore = Roact.createElement(
                    Button,
                    {
                        buttonType = ButtonType.Secondary,
                        onActivated = arg1.props.onActivated,
                        size = uDim2,
                        text = arg2.showMore
                    }
                )
            })
        }
        return createFragment(tbl1)
    end)
end

local function ShowMoreButtonWrapper(arg1)
    local var2 = useDesignTokens()

    return Roact.createElement(
        var1,
        Cryo.Dictionary.join({
            maxWidth = var2.LuaApps.FriendsLanding.ShowMore.ButtonWidth,
            buttonHeight = var2.LuaApps.FriendsLanding.ShowMore.ButtonHeight
        }, arg1)
    )
end

return ShowMoreButtonWrapper
