-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TrustedContacts = script:FindFirstAncestor("TrustedContacts")
local TrustedContactsParent = TrustedContacts.Parent

local React = require(TrustedContactsParent.React)
local FocusNavigationUtils = require(TrustedContactsParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusOnMount = FocusNavigationUtils.useFocusOnMount
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local InputHandlers = require(TrustedContactsParent.InputHandlers)
local useMostRecentOrDefaultFocusBehavior = require(TrustedContactsParent.ReactFocusNavigation).useMostRecentOrDefaultFocusBehavior

local Responsive = require(TrustedContactsParent.Responsive)
local Foundation = require(TrustedContactsParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local Loading = Foundation.Loading

local FoundationText = Foundation.Text
local Button = Foundation.Button
local View = Foundation.View
local Sheet = Foundation.Sheet
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior

local SocialMetadataSection = require(TrustedContacts.Components.SocialMetadataSection)
local num1 = game:DefineFastInt("TCMountMinLoadingTimeMs", 0)
local FFlagTCLearnMoreLink = require(TrustedContacts.Flags.FFlagTCLearnMoreLink)

local FFlagTrustedContactsModalFixFocusNavigation = require(TrustedContacts.Flags.FFlagTrustedContactsModalFixFocusNavigation)
local FFlagTrustedContactsSheetFocusNavigation = require(TrustedContacts.Flags.FFlagTrustedContactsSheetFocusNavigation)

local _useModalButtonActions = require(script.Parent.useModalButtonActions)

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

return function(tbl2)
    local isVerticallyConstrained = tbl2.isVerticallyConstrained
    local var1 = Responsive.useOrientation()
    local onCloseModal = tbl2.onCloseModal

    local eventHandlers = if FFlagTrustedContactsModalFixFocusNavigation then React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                onCloseModal()
                arg1:cancel()
            end)
        }
        return result
    end, { onCloseModal }) else nil

    local isFocusable = FFlagTrustedContactsSheetFocusNavigation and FFlagTrustedContactsModalFixFocusNavigation
    local var4, var5

    if FFlagTrustedContactsSheetFocusNavigation then
        local var6 = useFocusRoot({
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            eventMap = eventMap,
            eventHandlers = eventHandlers,
            isAutoFocusRoot = true,
            isFocusable = isFocusable,
            shouldRestoreFocus = false
        })

        var4, var5 = useMostRecentOrDefaultFocusBehavior(var6)
    else
        var4 = nil
        var5 = nil
    end

    local var6

    if FFlagTrustedContactsModalFixFocusNavigation then
        local var7 = useFocusOnMount

        if not isFocusable then
            var4 = nil
        end

        var6 = var7(var4)
    else
        var6 = nil
    end

    local bool1 = var1 == Responsive.DefaultKey
    local var7, var8 = React.useState(bool1)
    local var9 = React.useRef(os.clock())
    React.useEffect(function()
        if bool1 then
            return
        end

        local var10 = os.clock() - var9.current
        local num2 = num1 / 1000

        if var10 < num2 then
            delay(num2 - var10, function()
                var8(false)
            end)

            return
        end

        var8(false)
    end, { bool1, var8 })

    if var7 then
        return React.createElement(
            Loading,
            {
                size = IconSize.Large,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5)
            }
        )
    end

    local modalButtonAction = if tbl2.modalButtonActions then tbl2.modalButtonActions[1] or nil else nil
    local modalButtonAction2 = if tbl2.modalButtonActions then tbl2.modalButtonActions[2] or nil else nil
    local createElement = React.createElement
    local root = Sheet.Root
    local tbl3 = {
        onClose = tbl2.onCloseModal,
        preferCenterSheet = true,
        ref = 0
    }
    if not isFocusable then
        var5 = nil
    end

    tbl3.ref = var5
    local tbl4 = {
        Header = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-heading-small text-align-x-left content-default",
                    Text = tbl2.headerText
                }
            )
        }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local tbl5 = { LayoutOrder = 2 }

    local tbl6 = { TextIntro = 0, Insights = 0 }
    local element

    if FFlagTCLearnMoreLink then
        element = React.createElement(View, {
            LayoutOrder = 1,
            tag = "col gap-small size-full-0 auto-y"
        }, {
            Text = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    tag = "size-full-0 auto-y text-wrap text-align-x-left",
                    Text = tbl2.descriptionText
                }
            ),
            LearnMore = React.createElement(FoundationText, {
                LayoutOrder = 2,
                tag = "size-0 auto-xy text-wrap text-align-x-left",
                Text = `<u>{tbl2.learnMoreText}</u>`,
                onActivated = tbl2.onLearnMoreClick,
                RichText = true
            })
        })
    else
        element = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                tag = "size-full-0 auto-y text-wrap text-align-x-left",
                Text = tbl2.descriptionText
            }
        )
    end

    tbl6.TextIntro = element

    tbl6.Insights = React.createElement(
        SocialMetadataSection,
        {
            userId = tbl2.userId,
            layoutOrder = 2,
            isVerticallyConstrained = isVerticallyConstrained
        }
    )
    tbl4.Content = createElement2(content, tbl5, tbl6)
    local element2

    if modalButtonAction or modalButtonAction2 then
        element2 = React.createElement(Sheet.Actions, nil, {
            First = modalButtonAction
                and React.createElement(Button, {
                    LayoutOrder = 1,
                    text = modalButtonAction.text or "",
                    onActivated = modalButtonAction.onActivated,
                    icon = modalButtonAction.icon,
                    isLoading = modalButtonAction.isLoading,
                    variant = ButtonVariant.Emphasis,
                    fillBehavior = FillBehavior.Fill,
                    width = UDim.new(1, 0),
                    ref = var6,
                    isDisabled = modalButtonAction.isDisabled
                })
                or nil,
            Second = modalButtonAction2
                and React.createElement(Button, {
                    LayoutOrder = 2,
                    text = modalButtonAction2.text or "",
                    onActivated = modalButtonAction2.onActivated,
                    icon = modalButtonAction2.icon,
                    isLoading = modalButtonAction2.isLoading,
                    variant = ButtonVariant.Standard,
                    fillBehavior = FillBehavior.Fill,
                    width = UDim.new(1, 0),
                    isDisabled = modalButtonAction2.isDisabled
                })
                or nil
        })
    else
        element2 = nil
    end

    tbl4.Actions = element2
    local modal = createElement(root, tbl3, tbl4)

    if isFocusable then
        return modal
    elseif FFlagTrustedContactsModalFixFocusNavigation then
        return React.createElement(FocusRoot, {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
            isAutoFocusRoot = true,
            isIsolated = true,
            eventHandlers = eventHandlers
        }, { Modal = modal })
    end

    return modal
end
