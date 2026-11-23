-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContactsParent = script:FindFirstAncestor("TrustedContacts").Parent

local React = require(TrustedContactsParent.React)

local UIBlox = require(TrustedContactsParent.UIBlox)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local useScreenSize = require(TrustedContactsParent.RobloxAppHooks).useScreenSize
local useNavigation = require(TrustedContactsParent.Navigation).useNavigation
local useLocalization = require(TrustedContactsParent.Localization).Hooks.useLocalization

local AppPage = require(TrustedContactsParent.RobloxAppEnums).AppPage

local Foundation = require(TrustedContactsParent.Foundation)
local Skeleton = Foundation.Skeleton

local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local AmpApiProvider = require(TrustedContactsParent.AmpUpsell).AmpApiProvider
local AccessResponseEnum = require(TrustedContactsParent.AmpUpsell).AmpEnums.AccessResponseEnum

local Analytics = require(script.Parent.Parent.Parent.Analytics)
local useTCAnalytics = Analytics.useTCAnalytics
local EventNames = Analytics.EventNames

local FStringCanAccessTrustedContactsAmpNameSpace = require(TrustedContactsParent.SharedFlags).FStringCanAccessTrustedContactsAmpNameSpace
local FStringIsVerified18PlusAmpFeature = require(TrustedContactsParent.SharedFlags).FStringIsVerified18PlusAmpFeature

local FFlagCreateConnectionsHub = require(TrustedContactsParent.SharedFlags).FFlagCreateConnectionsHub
local bool1 = game:DefineFastFlag("ConsoleFriendsPageNavigation", false)

local function TextWithIcon(tbl1)
    return React.createElement("Frame", {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, tbl1.iconPadding),
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Icon = React.createElement(Icon, { name = tbl1.icon, size = IconSize.Small, LayoutOrder = 1 }),
        Text = React.createElement(
            FoundationText,
            {
                tag = "auto-y grow size-full-0 text-align-x-left text-wrap",
                Text = tbl1.text,
                LayoutOrder = 2
            }
        )
    })
end

local function TrustedContactsEducationModal(_)
    local screenSize = useScreenSize()
    local var2 = useNavigation()
    local var3 = useTokens()

    local var4, var5 = React.useState(AccessResponseEnum.Pending)
    React.useEffect(function()
        local var6 = AmpApiProvider.upsellFeatureAccess(FStringIsVerified18PlusAmpFeature, {}, FStringCanAccessTrustedContactsAmpNameSpace)
        var5(var6.access)
    end, {})

    local fireAnalyticsEvent = useTCAnalytics().fireAnalyticsEvent

    React.useEffect(function()
        fireAnalyticsEvent(EventNames.TCEducationModalSeen)
    end, {})

    local onCloseClicked = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCEducationCloseClicked)
        var2.pop()
    end, { var2 })

    local onActivated = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCEducationGotItClicked)
        var2.pop()
    end, { var2 })

    local var1 = React.useCallback(function()
        fireAnalyticsEvent(EventNames.TCEducationManageConnectionsClicked)
        if FFlagCreateConnectionsHub then
            var2.navigate(AppPage.CoHubMyConnections)
        elseif bool1 then
            var2.navigate(AppPage.ViewFriends)
        else
            var2.replace(AppPage.ViewFriends)
        end
    end, { var2 })

    local var9 = useLocalization({
        title = "Feature.Friends.TCEducation.Title",
        textIntro = "Feature.Friends.TFEducation.Modal.TextIntro",
        textIntro18Plus = "Feature.Friends.TFEducation.Modal.TextIntro.EighteenPlus",
        textChatWithoutFilters = "Feature.Friends.TCFeature.ChatWithoutFilters",
        textPartyVoice = "Feature.Friends.TCFeature.PartyVoice",
        textAndMore = "Feature.Friends.TCFeature.AndMore",
        textOutro = "Feature.Friends.TFEducation.Modal.TextOutro",
        textOutro18Plus = "Feature.Friends.TFEducation.Modal.TextOutro.EighteenPlus",
        buttonManage = "Feature.Avatar.Heading.Manage",
        buttonGotIt = "Feature.Friends.Button.GotIt"
    })

    local createElement = React.createElement
    local var10 = PartialPageModal
    local tbl1 = {
        title = var9.title,
        screenSize = screenSize,
        onCloseClicked = onCloseClicked,
        buttonStackProps = {
            buttons = {
                {
                    buttonType = ButtonType.PrimaryContextual,
                    props = {
                        onActivated = onActivated,
                        text = var9.buttonGotIt
                    }
                },
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = var1,
                        text = var9.buttonManage
                    }
                }
            },
            forcedFillDirection = Enum.FillDirection.Horizontal
        }
    }
    local tbl2 = { ViewContainer = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        TextContainer = 0
    }
    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        LayoutOrder = 2,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1
    }
    local tbl6 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var3.Padding.Large),
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        OuterPadding = React.createElement(
            "UIPadding",
            {
                PaddingTop = UDim.new(0, var3.Padding.Medium),
                PaddingBottom = UDim.new(0, var3.Padding.Large)
            }
        ),
        ConnectTextIntro = if var4 == AccessResponseEnum.Pending then React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 1 }) else React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                tag = "auto-y grow size-full-0 text-align-x-left text-wrap",
                Text = if var4 == AccessResponseEnum.Granted then var9.textIntro18Plus else var9.textIntro
            }
        ),
        ConnectOptionText1 = React.createElement(TextWithIcon, {
            layoutOrder = 2,
            icon = "icons/menu/platformChatOff_small",
            text = var9.textChatWithoutFilters,
            iconPadding = var3.Padding.Medium
        }),
        ConnectOptionText2 = React.createElement(TextWithIcon, {
            layoutOrder = 3,
            icon = "icons/controls/microphone_small",
            text = var9.textPartyVoice,
            iconPadding = var3.Padding.Medium
        }),
        ConnectOptionText3 = React.createElement(
            TextWithIcon,
            {
                layoutOrder = 4,
                icon = "icons/actions/edit/add_small",
                text = var9.textAndMore,
                iconPadding = var3.Padding.Medium
            }
        ),
        ConnectTextOutro = if var4 == AccessResponseEnum.Pending then React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 60), LayoutOrder = 5 }) else React.createElement(
            FoundationText,
            {
                LayoutOrder = 5,
                tag = "auto-y grow size-full-0 text-align-x-left text-wrap",
                Text = if var4 == AccessResponseEnum.Granted then var9.textOutro18Plus else var9.textOutro
            }
        )
    }
    tbl4.TextContainer = createElement3(str2, tbl5, tbl6)
    tbl2.ViewContainer = createElement2(str1, tbl3, tbl4)
    return createElement(var10, tbl1, tbl2)
end

return TrustedContactsEducationModal
