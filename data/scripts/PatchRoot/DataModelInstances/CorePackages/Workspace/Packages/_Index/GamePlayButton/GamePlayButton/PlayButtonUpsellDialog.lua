-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local GamePlayButtonParent = GamePlayButton.Parent

local PlayButtonUpsellBody = require(GamePlayButton.PlayButtonUpsellBody)

local React = require(GamePlayButtonParent.React)
local Foundation = require(GamePlayButtonParent.Foundation)
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local AppLinking = require(GamePlayButtonParent.RoactServiceTags).AppLinking

local CentralOverlay = require(GamePlayButtonParent.CentralOverlay)
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local CentralOverlayType = require(GamePlayButtonParent.RobloxAppEnums).CentralOverlayType

local extractAndStyleRichTextLinks = require(GamePlayButtonParent.DiscoveryUtils).extractAndStyleRichTextLinks

local FFlagEnablePlayButtonWizardVPCPrologue = require(GamePlayButton.Flags.FFlagEnablePlayButtonWizardVPCPrologue)

local function PlayButtonUpsellDialog(tbl1)
    local var1 = useTokens()
    local var2 = useDispatch()
    local var3 = useRoactService(AppLinking)

    local var4 = React.useMemo(function()
        local var4, styledText = extractAndStyleRichTextLinks(tbl1.bodyText)

        return {
            link = if #var4 > 0 then var4[1] else nil,
            styledText = styledText
        }
    end, { tbl1.bodyText })

    local var5 = React.useCallback(function()
        if not var4.link then
            return
        end

        tbl1.onCloseModal()

        var2(SetCentralOverlay(CentralOverlayType.LeaveRobloxAlert, {
            continueFunc = function()
                var3:openURL(var4.link)
                var2(CloseCentralOverlay())
            end
        }))
    end, {
        tbl1.onCloseModal,
        var4.link,
        var2,
        var3
    })
    local createElement = React.createElement
    local root = Dialog.Root
    local tbl2 = {
        size = DialogSize.Medium,
        hasBackdrop = false,
        onClose = tbl1.onCloseModal
    }
    local tbl3 = {
        Title = React.createElement(Dialog.Title, { LayoutOrder = 1, text = tbl1.titleText }),
        Content = 0,
        Actions = 0
    }

    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl4 = { LayoutOrder = 2 }

    local tbl5 = { BodyText = 0 }
    local element

    if FFlagEnablePlayButtonWizardVPCPrologue then
        element = React.createElement(PlayButtonUpsellBody, { bodyText = tbl1.bodyText, onCloseModal = tbl1.onCloseModal })
    else
        local createElement3 = React.createElement
        local str1 = "TextButton"
        local tbl6 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            RichText = true,
            Size = UDim2.new(1, 0, 0, 0),
            Text = var4.styledText,
            TextSize = var1.Typography.BodyLarge.FontSize,
            FontFace = normalizeFontFace(var1.Typography.BodyLarge.Font),
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            Active = var4.link ~= nil,
            Selectable = var4.link ~= nil
        }
        local activated = React.Event.Activated

        if not var4.link then
            var5 = nil
        end

        tbl6[activated] = var5
        element = createElement3(str1, tbl6)
    end

    tbl5.BodyText = element
    tbl3.Content = createElement2(content, tbl4, tbl5)

    tbl3.Actions = React.createElement(Dialog.Actions, {
        LayoutOrder = 3,
        actions = {
            {
                text = tbl1.cancelButtonText,
                variant = ButtonVariant.Standard,
                onActivated = tbl1.onCancelButtonClick
            },
            {
                text = tbl1.actionButtonText,
                variant = ButtonVariant.Emphasis,
                onActivated = tbl1.onActionButtonClick
            }
        }
    })
    return createElement(root, tbl2, tbl3)
end

return PlayButtonUpsellDialog
