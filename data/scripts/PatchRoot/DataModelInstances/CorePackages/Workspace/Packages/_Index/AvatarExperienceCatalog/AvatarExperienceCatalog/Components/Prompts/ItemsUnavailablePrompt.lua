-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local RoactNavigation = require(AvatarExperienceCatalogParent.RoactNavigation)

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local sendAXCounterV2 = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).sendAXCounterV2

local Constants = require(AvatarExperienceCatalog.Constants)

local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector
local withMappedNavigationParams = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation).withMappedNavigationParams
local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization

local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local ModalWindow = require(AvatarExperienceCatalogParent.UIBlox).App.Dialog.Modal.ModalWindow
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local FFlagAXInventoryDurablesSupport = AvatarExperienceFlags.FFlagAXInventoryDurablesSupport

local function func1(arg1)
    return arg1.ScreenSize
end

local tbl1 = {
    UnavailableItems = {
        TitleText = "Feature.Avatar.UnavailableItems.TitleText",
        BodyText = "Feature.Avatar.UnavailableItems.BodyText",
        BodyTextMultiple = "Feature.Avatar.UnavailableItems.BodyTextMultiple"
    },
    ItemsRemovedFromAvatar = {
        TitleText = "Feature.Avatar.ItemsRemovedFromAvatar.TitleText",
        BodyText = "Feature.Avatar.UnavailableItems.BodyText",
        BodyTextMultiple = "Feature.Avatar.UnavailableItems.BodyTextMultiple"
    },
    RevokedItems = {
        TitleText = "Feature.Avatar.ItemsRemovedFromAvatar.TitleText",
        BodyText = "Feature.Avatar.RevokedItems.BodyText",
        BodyTextMultiple = "Feature.Avatar.RevokedItems.BodyTextMultiple"
    },
    ItemDidNotMeetRobloxCommunityStandards = {
        TitleText = "Feature.Avatar.ItemDidNotMeetRobloxCommunityStandards.TitleText",
        BodyText = "Feature.Avatar.ItemDidNotMeetRobloxCommunityStandards.BodyText"
    },
    PartiallyExpiredItems = FFlagAXInventoryDurablesSupport
        and {
            TitleText = "Feature.Durables.PartiallyExpiredItems.TitleText",
            BodyText = "Feature.Durables.PartiallyExpiredItems.BodyText"
        }
        or nil
}

return (withMappedNavigationParams(function(tbl2) -- name: ItemsUnavailablePrompt
    React.useEffect(function()
        sendAXCounterV2(Constants.COUNTERS.ItemsUnavailablePromptShown, { messageType = tbl2.messageType })
    end, {})

    local tbl3 = {}
    if FFlagAXInventoryDurablesSupport then
        if tbl2.items then
            for _, item in tbl2.items do
                if item.categoryLoc then
                    tbl3[item.categoryLoc] = item.categoryLoc
                end
            end
        end
    else
        for _, item in tbl2.items do
            if item.categoryLoc then
                tbl3[item.categoryLoc] = item.categoryLoc
            end
        end
    end

    local var1 = useLocalization(tbl3)

    local function localizeCategory(tbl4) -- Luacid: Inlined by compiler; 3 call sites recovered
        return if tbl4.categoryLoc and var1[tbl4.categoryLoc] then var1[tbl4.categoryLoc] else tbl4.category or ""
    end

    local function createItemListString(items)
        local str1 = ""
        for _, item in items do
            str1 ..= "• " .. localizeCategory(item) .. " \"" .. item.itemName .. "\"" .. (if item == items[#items] then "" else "\n")
        end
        return str1
    end

    local bodyText

    if not FFlagAXInventoryDurablesSupport or tbl2.items and #tbl2.items > 0 then
        bodyText = tbl1[tbl2.messageType].BodyTextMultiple
            and #tbl2.items > 1
            and {
                tbl1[tbl2.messageType].BodyTextMultiple,
                items = createItemListString(tbl2.items),
                lineBreak = "\n\n"
            }
            or {
                tbl1[tbl2.messageType].BodyText,
                item = tbl2.items[1].itemName,
                category = localizeCategory(tbl2.items[1]),
                lineBreak = "\n\n"
            }
    else
        bodyText = tbl1[tbl2.messageType].BodyText
    end

    local var2 = useLocalization({
        ConfirmText = "Feature.Avatar.UnavailableItems.ConfirmText",
        TitleText = tbl1[tbl2.messageType].TitleText,
        BodyText = bodyText,
        ViewInbox = "Feature.Avatar.RevokedItems.ViewInbox"
    })

    local screenSize = useSelector(func1)

    local var4 = React.useCallback(function()
        tbl2.navigation.dispatch(RoactNavigation.Actions.back(nil))
    end, { tbl2.navigation })

    local onActivated = React.useCallback(function()
        var4()
        if tbl2.onConfirm then
            tbl2.onConfirm()
        end
    end, { tbl2.onConfirm, var4 })

    local var3 = React.useCallback(function()
        var4()
        if tbl2.navigateDown then
            tbl2.navigateDown()
        end
    end, { tbl2.navigateDown, var4 })

    local function func2()
        return React.createElement(View, { tag = "col gap-medium auto-y size-full-0 fill-x" }, {
            Buttons = React.createElement(Button, {
                tag = "size-full-0 auto-y",
                onActivated = onActivated,
                text = var2.ConfirmText,
                variant = ButtonVariant.Emphasis,
                width = UDim.new(1, 0),
                fillBehavior = FillBehavior.Fill,
                size = InputSize.Medium,
                LayoutOrder = 3
            }),
            ViewDetailButton = if tbl2.messageType == "RevokedItems" then React.createElement(Button, {
                tag = "size-full-0 auto-y",
                onActivated = var3,
                text = var2.ViewInbox,
                variant = ButtonVariant.Standard,
                width = UDim.new(1, 0),
                LayoutOrder = 4
            }) else nil
        })
    end

    return React.createElement(ModalWindow, { screenSize = screenSize, isFullHeight = false }, {
        ViewFrame = React.createElement(View, {
            tag = "auto-y size-full-0 padding-xxlarge col align-x-left align-y-top"
        }, {
            ContentContainer = (function()
                return React.createElement(View, {
                    tag = "auto-y size-full-0 padding-bottom-xxlarge col align-x-left align-y-top"
                }, {
                    PromptBodyTitle = React.createElement(FoundationText, {
                        tag = "auto-xy text-align-x-left text-truncate-end text-heading-small text-wrap",
                        Text = var2.TitleText,
                        LayoutOrder = 1,
                        padding = {
                            bottom = UDim.new(0, 8)
                        }
                    }),
                    PromptBodyText = React.createElement(
                        FoundationText,
                        {
                            tag = "auto-xy text-align-x-left text-body-large text-wrap",
                            Text = var2.BodyText,
                            LayoutOrder = 2
                        }
                    )
                })
            end)(),
            ButtonContainer = func2()
        })
    })
end))
