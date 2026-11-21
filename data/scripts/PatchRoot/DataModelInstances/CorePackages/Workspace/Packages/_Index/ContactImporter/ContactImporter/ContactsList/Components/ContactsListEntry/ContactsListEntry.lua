-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local ContactImporterParent = ContactImporter.Parent
local dependencies = require(ContactImporter.dependencies)
local Constants = require(ContactImporter.Common.Constants)
local NavigationRodux = require(ContactImporterParent.NavigationRodux)
local AppPage = require(ContactImporterParent.RobloxAppEnums).AppPage

local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local RoactRodux = dependencies.RoactRodux

local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local withStyle = UIBlox.Style.withStyle
local LoadableImage = UIBlox.App.Loading.LoadableImage

local getFFlagContactsListEntryUpdatedTruncationFix = require(ContactImporter.Flags.getFFlagContactsListEntryUpdatedTruncationFix)

local NavigateDown = NavigationRodux.Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ContactImporterParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ContactImporterParent.RobloxAppNavigation).NavigationCommands else nil
local var1 = Roact.PureComponent:extend("ContactsListEntry")

var1.defaultProps = { contextualInfo = "", contactName = "", hasDivider = false }

function var1.init(arg1)
    arg1:setState({ clicked = false, contactNameOffset = 0 })

    function arg1.addButtonSizeChanged(arg2)
        arg1:setState({ contactNameOffset = 0 - (arg2.AbsoluteSize.X + 10) })
    end

    function arg1.requestContactFriendship()
        local props = arg1.props
        props.requestFriendship(props.contactId)
    end

    function arg1.openProfilePeekView()
        local props = arg1.props
        arg1.props.navigateToProfile(
            {
                name = AppPage.ProfilePlatform,
                detail = props.contactId,
                extraProps = {
                    profileType = Constants.CONTACT
                }
            }
        )
    end
end

function var1.render(arg1)
    local props = arg1.props
    local bool1 = not props.hasSentRequest

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Name = props.deviceContactId,
            Size = UDim2.new(1, 0, 0, 72),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder
        }
        local tbl2 = { entryContent = 0, divider = 0 }
        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }
        local tbl4 = {
            layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 1)
            }),
            headshotThumbnailContainer = 0,
            headshotPadding = 0,
            middleTextGroup = 0,
            requestContactButton = 0
        }
        local createElement3 = Roact.createElement
        local tbl5 = {
            Size = UDim2.new(0, 64, 0, 64),
            LayoutOrder = 1,
            BackgroundTransparency = 1
        }

        local createElement4 = Roact.createElement
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            [Roact.Event.Activated] = arg1.openProfilePeekView
        }
        local tbl7 = {
            createElement4("ImageButton", tbl6, {
                headshotThumbnailImage = Roact.createElement(LoadableImage, {
                    Size = UDim2.new(0, 64, 0, 64),
                    Image = props.headshotThumbnailUrl,
                    onLoaded = function() end,
                    BackgroundTransparency = 1,
                    useShimmerAnimationWhileLoading = true,
                    showFailedStateWhenLoadingFailed = true
                })
            })
        }
        tbl4.headshotThumbnailContainer = createElement3("Frame", tbl5, tbl7)

        tbl4.headshotPadding = Roact.createElement("Frame", { Size = UDim2.new(0, 12, 1, 0), BackgroundTransparency = 1, LayoutOrder = 2 })

        local createElement5 = Roact.createElement
        local str3 = "TextButton"
        local tbl8 = {
            Size = UDim2.new(1, -123, 1, 0),
            Text = "",
            BackgroundTransparency = 1,
            [Roact.Event.Activated] = arg1.openProfilePeekView,
            LayoutOrder = 3
        }
        local tbl9 = {
            layout = Roact.createElement(
                "UIListLayout",
                {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            contactNameLabel = 0
        }
        local element

        if getFFlagContactsListEntryUpdatedTruncationFix() then
            element = Roact.createElement(StyledTextLabel, {
                size = UDim2.new(1, arg1.state.contactNameOffset, 0, 20),
                colorStyle = arg2.Theme.TextEmphasis,
                fontStyle = arg2.Font.Header2,
                lineHeight = 1,
                text = props.contactName,
                fluidSizing = false,
                richText = false,
                textWrapped = false,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Bottom,
                textTruncate = Enum.TextTruncate.AtEnd,
                layoutOrder = 1
            })
        else
            element = Roact.createElement(StyledTextLabel, {
                automaticSize = Enum.AutomaticSize.Y,
                colorStyle = arg2.Theme.TextEmphasis,
                fontStyle = arg2.Font.Header2,
                lineHeight = 1,
                text = props.contactName,
                textXAlignment = Enum.TextXAlignment.Left,
                textYAlignment = Enum.TextYAlignment.Bottom,
                layoutOrder = 1
            })
        end

        tbl9.contactNameLabel = element
        tbl4.middleTextGroup = createElement5(str3, tbl8, tbl9)
        local element2

        if bool1 then
            element2 = Roact.createElement(Button, {
                buttonType = ButtonType.PrimarySystem,
                icon = Images["icons/actions/friends/friendAdd"],
                size = UDim2.fromOffset(44, 36),
                onActivated = arg1.requestContactFriendship,
                layoutOrder = 4,
                [Roact.Change.AbsoluteSize] = if getFFlagContactsListEntryUpdatedTruncationFix() then arg1.addButtonSizeChanged else nil
            })
        else
            local createElement6 = Roact.createElement
            local var2 = Button
            local tbl10 = {
                buttonType = ButtonType.Secondary,
                icon = Images["icons/actions/friends/friendpending"],
                size = UDim2.fromOffset(44, 36),
                onActivated = function() end,
                isDisabled = true,
                layoutOrder = 4,
                [Roact.Change.AbsoluteSize] = if getFFlagContactsListEntryUpdatedTruncationFix() then arg1.addButtonSizeChanged else nil
            }
            element2 = createElement6(var2, tbl10)
        end

        tbl4.requestContactButton = element2
        tbl2.entryContent = createElement2(str2, tbl3, tbl4)

        tbl2.divider = if props.hasDivider then Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = arg2.Theme.Divider.Color,
            BackgroundTransparency = arg2.Theme.Divider.Transparency
        }) else nil
        return createElement(str1, tbl1, tbl2)
    end)
end

return RoactRodux.connect(nil, function(callback) -- name: mapDispatchToProps
    return {
        navigateToProfile = function(arg1)
            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.down(NavigationCommands.fromLegacyPage(arg1))
                return
            end
            callback(NavigateDown(arg1))
        end
    }
end)(var1)
