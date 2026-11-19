-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local GetTextSize = require(CorePackages.Workspace.Packages.Style).GetTextSize
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParentParent = script.Parent.Parent.Parent

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local Assets = require(scriptParentParentParent.Resources.Assets)

local ThemedTextLabel = require(scriptParentParentParent.Components.ThemedTextLabel)
local FocusHandler = require(scriptParentParentParent.Components.Connection.FocusHandler)
local RootedConnection = require(scriptParentParentParent.Components.Connection.RootedConnection)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local var1 = Roact.PureComponent:extend("LoadingFriendsError")

var1.validateProps = t.strictInterface({ onRetry = t.callback, canCaptureFocus = t.boolean })

function var1.init(arg1)
    arg1.buttonRef = Roact.createRef()
end

function var1.render(arg1)
    local props = arg1.props

    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Font = {
                BaseSize = 1,
                Body = {
                    Font = tokens.Typography.BodyLarge.Font,
                    RelativeSize = tokens.Typography.BodyLarge.FontSize
                }
            }
        }
    end, function(arg2)
        return withLocalization({ errorOccured = "CoreScripts.InGameMenu.InviteFriends.ErrorOccured" })(function(arg3)
            local var2 = arg2.Font.Body.RelativeSize * arg2.Font.BaseSize
            local textSizeY = GetTextSize(
                arg3.errorOccured,
                var2,
                arg2.Tokens.Typography.BodyLarge.Font,
                Vector2.new(304, math.huge),
                { addTemporaryPadding = false }
            ).Y

            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl1 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 304, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                AnchorPoint = Vector2.new(0.5, 0)
            }
            local tbl2 = {
                Layout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }),
                Icon = 0,
                TextContainer = 0,
                RootedConnection = 0
            }
            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element = Roact.createElement(Image, {
                    Image = Assets.Images.Friends.Image,
                    imageRect = {
                        offset = Assets.Images.Friends.ImageRectOffset,
                        size = Assets.Images.Friends.ImageRectSize
                    },
                    Size = UDim2.new(0, 64, 0, 64),
                    imageStyle = {
                        Color3 = Color3.new(1, 1, 1),
                        Transparency = 0.5
                    },
                    LayoutOrder = 1
                })
            else
                element = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Image = Assets.Images.Friends,
                    Size = UDim2.new(0, 64, 0, 64),
                    ImageTransparency = 0.5,
                    LayoutOrder = 1
                })
            end

            tbl2.Icon = element

            tbl2.TextContainer = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, textSizeY + 36),
                    LayoutOrder = 2
                },
                {
                    Text = Roact.createElement(ThemedTextLabel, {
                        fontKey = "Body",
                        themeKey = "TextEmphasis",
                        Text = arg3.errorOccured,
                        Position = UDim2.new(0, 0, 0, 10),
                        Size = UDim2.new(1, 0, 1, -36),
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextWrapped = true
                    })
                }
            )

            tbl2.RootedConnection = Roact.createElement(RootedConnection, {
                render = function(arg4)
                    return Roact.createElement(FocusHandler, {
                        isFocused = props.canCaptureFocus and arg4,
                        didFocus = function()
                            GuiService.SelectedCoreObject = arg1.buttonRef:getValue()
                        end
                    }, {
                        RetryButton = arg4
                            and Roact.createElement(Button, {
                                buttonType = ButtonType.Secondary,
                                layoutOrder = 3,
                                size = UDim2.new(1, 0, 0, 48),
                                icon = Assets.Images.RetryIcon,
                                onActivated = props.onRetry,
                                buttonRef = arg1.buttonRef
                            })
                            or nil
                    })
                end
            })

            return createElement(str1, tbl1, tbl2)
        end)
    end)
end

return var1
