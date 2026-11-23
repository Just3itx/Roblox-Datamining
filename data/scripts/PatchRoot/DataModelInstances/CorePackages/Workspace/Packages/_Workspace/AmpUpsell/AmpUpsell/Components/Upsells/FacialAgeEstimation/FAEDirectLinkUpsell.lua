-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local React = require(AmpUpsellParent.React)

local AppLinking = require(AmpUpsellParent.RoactServiceTags).AppLinking
local useRoactService = require(AmpUpsellParent.RobloxAppHooks).useRoactService
local useScreenSize = require(AmpUpsellParent.RobloxAppHooks).useScreenSize
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization

local UIBlox = require(AmpUpsellParent.UIBlox)
local PartialPageModal = UIBlox.App.Dialog.Modal.PartialPageModal
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images

local Foundation = require(AmpUpsellParent.Foundation)
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local authButtonClick = require(AmpUpsellParent.AuthAnalytics).Events.authButtonClick

local function FAEDirectLinkUpsell(tbl1)
    local webLink = tbl1.webLink
    local onCancel = tbl1.onCancel
    local sessionId = tbl1.sessionId
    local entryPointEventCtx = tbl1.entryPointEventCtx

    local screenSize = useScreenSize()
    local var2 = useTokens()
    local var3 = useRoactService(AppLinking)

    local var4 = useLocalization({
        title = "Amp.FAEUpsell.Modal.ExternalLink.Title",
        bodyText = "Amp.FAEUpsell.Modal.ExternalLink.Text",
        startBtn = "Amp.FAEUpsell.Modal.ExternalLink.ButtonStart",
        cancelBtn = "Amp.FAEUpsell.Modal.ExternalLink.ButtonCancel"
    })

    local onActivated = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "startFaeNonNative", sessionId)
        var3:openURL(webLink)
    end, {
        var3,
        webLink,
        sessionId,
        entryPointEventCtx
    })
    local var6 = React.useCallback(function()
        authButtonClick(entryPointEventCtx, "cancelFaeNonNative", sessionId)
        onCancel()
    end, { onCancel, sessionId, entryPointEventCtx })

    return React.createElement(PartialPageModal, {
        title = var4.title,
        screenSize = screenSize,
        onCloseClicked = var6,
        buttonStackProps = {
            forcedFillDirection = Enum.FillDirection.Vertical,
            buttons = {
                {
                    buttonType = ButtonType.Secondary,
                    props = {
                        onActivated = var6,
                        text = var4.cancelBtn
                    }
                },
                {
                    buttonType = ButtonType.PrimaryContextual,
                    props = {
                        icon = Images["icons/navigation/externallink_medium"],
                        onActivated = onActivated,
                        text = var4.startBtn
                    }
                }
            }
        }
    }, {
        ViewFrame = React.createElement(
            "Frame",
            {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0)
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Vertical,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                OuterPadding = React.createElement(
                    "UIPadding",
                    {
                        PaddingTop = UDim.new(0, var2.Padding.XXLarge),
                        PaddingBottom = UDim.new(0, var2.Padding.XXLarge)
                    }
                ),
                BodyText = React.createElement(
                    FoundationText,
                    {
                        tag = "auto-y grow size-full-0 text-align-x-left text-wrap",
                        Text = var4.bodyText,
                        LayoutOrder = 1
                    }
                )
            }
        )
    })
end
return FAEDirectLinkUpsell
