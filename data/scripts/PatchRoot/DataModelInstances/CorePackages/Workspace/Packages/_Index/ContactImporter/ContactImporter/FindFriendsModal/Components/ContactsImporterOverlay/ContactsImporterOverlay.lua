-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local dependencies = require(scriptParentParentParentParent.dependencies)

local t = dependencies.t
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local withLocalization = dependencies.withLocalization

local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local withStyle = UIBlox.Style.withStyle
local TextKeys = require(scriptParentParentParentParent.Common.TextKeys)
local Dash = dependencies.Dash
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace
local FFlagFontFaceSocialFriends = dependencies.FFlagFontFaceSocialFriends

local var1 = Roact.PureComponent:extend("ContactsImporterOverlay")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    onCloseClicked = Dash.isCallable,
    onConnectContacts = Dash.isCallable,
    onLearnMoreClick = Dash.isCallable,
    onAddFriendsActivated = Dash.isCallable,
    isFromAddFriendsPage = t.boolean,
    isFromSignup = t.optional(t.boolean)
})

function var1.render(arg1)
    return withLocalization({
        connectWithFriends = TextKeys.CONTACTS_LIST_TITLE,
        connectWithFriendsBody = TextKeys.CONNECT_CONTACTS_BODY,
        connectWithFriendsCaption = TextKeys.CONNECT_CONTACTS_CAPTION,
        getStarted = TextKeys.GET_STARTED,
        closeModal = TextKeys.CLOSE_MODAL,
        goToAddFriends = TextKeys.NOT_NOW,
        learnMore = TextKeys.LEARN_MORE
    })(
        function(arg2)
            return withStyle(function(arg3)
                local theme = arg3.Theme
                local font = arg3.Font
                local props = arg1.props

                local buttons = {}
                if props.isFromAddFriendsPage or props.isFromSignup then
                    table.insert(
                        buttons,
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = props.onCloseClicked,
                                text = arg2.goToAddFriends
                            }
                        }
                    )
                else
                    table.insert(
                        buttons,
                        {
                            buttonType = ButtonType.Secondary,
                            props = {
                                onActivated = props.onAddFriendsActivated,
                                text = arg2.goToAddFriends
                            }
                        }
                    )
                end
                table.insert(
                    buttons,
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = props.onConnectContacts,
                            text = arg2.getStarted
                        }
                    }
                )
                local createElement = Roact.createElement
                local var2 = PartialPageModal
                local tbl2 = {
                    title = arg2.connectWithFriends,
                    screenSize = props.screenSize,
                    onCloseClicked = props.onCloseClicked,
                    buttonStackProps = {
                        buttons = buttons,
                        buttonHeight = 48,
                        marginBetween = 6,
                        forcedFillDirection = Enum.FillDirection.Vertical
                    }
                }
                local tbl3 = { ViewContainer = 0 }
                local createElement2 = Roact.createElement
                local str1 = "Frame"
                local tbl4 = {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundTransparency = 1
                }
                local tbl5 = {
                    UIListLayout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 12),
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }),
                    UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 24), PaddingBottom = UDim.new(0, 36) }),
                    IconContainer = Roact.createElement("Frame", {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromOffset(120, 132)
                    }, {
                        Icon = Roact.createElement(ImageSetLabel, {
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundTransparency = 1,
                            ImageTransparency = theme.IconEmphasis.Transparency,
                            Image = Images["icons/graphic/connectcontacts_xlarge"],
                            Size = UDim2.fromOffset(IconSize.XLarge, IconSize.XLarge),
                            Position = UDim2.fromScale(0.5, 0.5),
                            LayoutOrder = 1
                        })
                    }),
                    Header = Roact.createElement(StyledTextLabel, {
                        text = arg2.connectWithFriendsBody,
                        fontStyle = font.Body,
                        colorStyle = theme.TextEmphasis,
                        size = UDim2.fromScale(1, 0),
                        automaticSize = Enum.AutomaticSize.Y,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        textXAlignment = Enum.TextXAlignment.Center,
                        textYAlignment = Enum.TextYAlignment.Top,
                        layoutOrder = 2
                    }),
                    Description = Roact.createElement(StyledTextLabel, {
                        text = arg2.connectWithFriendsCaption,
                        fontStyle = font.CaptionBody,
                        colorStyle = theme.TextDefault,
                        size = UDim2.fromScale(1, 0),
                        automaticSize = Enum.AutomaticSize.Y,
                        textTruncate = Enum.TextTruncate.AtEnd,
                        textXAlignment = Enum.TextXAlignment.Center,
                        textYAlignment = Enum.TextYAlignment.Top,
                        layoutOrder = 3
                    }),
                    LearnMore = Roact.createElement("TextButton", {
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundTransparency = 1,
                        Font = if FFlagFontFaceSocialFriends then nil else arg3.Font.CaptionBody.Font,
                        FontFace = if FFlagFontFaceSocialFriends then normalizeFontFace(arg3.Tokens.Typography.BodySmall.Font) else nil,
                        Size = UDim2.fromScale(1, 0),
                        Text = arg2.learnMore,
                        TextColor3 = theme.TextEmphasis.Color,
                        TextSize = font.CaptionBody.RelativeSize * font.BaseSize,
                        TextTransparency = theme.TextEmphasis.Transparency,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        LayoutOrder = 4,
                        [Roact.Event.Activated] = props.onLearnMoreClick
                    })
                }
                tbl3.ViewContainer = createElement2(str1, tbl4, tbl5)
                return createElement(var2, tbl2, tbl3)
            end)
        end
    )
end

return var1
