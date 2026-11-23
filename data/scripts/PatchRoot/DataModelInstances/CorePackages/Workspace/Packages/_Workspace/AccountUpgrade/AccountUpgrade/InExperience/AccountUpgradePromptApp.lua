-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local Foundation = require(AccountUpgradeParent.Foundation)
local CoreScriptsRootProvider = require(AccountUpgradeParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local InExperienceProviderContainer = require(AccountUpgradeParent.InExperienceContainer).InExperienceProviderContainer

local _AccountUpgradeFlow = require(AccountUpgrade.AccountUpgradeFlow)
local AccountUpgradeContainer = require(AccountUpgrade.Components.AccountUpgradeContainer)
local AccountUpgradeSuccessView = require(AccountUpgrade.SuccessModal.AccountUpgradeSuccessView)
local respawnIntoExperience = require(script.Parent.respawnIntoExperience)
local resolveSuccessIdentity = require(script.Parent.resolveSuccessIdentity)

local FStringAccountUpgradeLinkedAccountType = require(AccountUpgrade.Flags.FStringAccountUpgradeLinkedAccountType)

local function AccountUpgradePromptApp(tbl1)
    local gui, ref = React.useState(nil)
    local var3, var4 = React.useState(nil)

    local localPlayer = Players.LocalPlayer
    local localPlayerName = if localPlayer then localPlayer.Name else nil
    local onComplete = tbl1.onComplete
    local onSignUpComplete = React.useCallback(function(tbl2)
        if tbl2.isSuccess then
            var4(tbl2)
        end
    end, {})

    local var6 = React.useCallback(function()
        local var6 = var3
        if var6 ~= nil then
            onComplete(var6)
        end
    end, { onComplete, var3 })

    local onRespawnNow = React.useCallback(function()
        var6()
        respawnIntoExperience()
    end, { var6 })

    local element

    if var3 ~= nil then
        local var8 = resolveSuccessIdentity
        local tbl2 = {
            username = localPlayerName,
            displayName = if localPlayer then localPlayer.DisplayName else nil
        }
        local var9 = var8(var3, tbl2)

        element = React.createElement(AccountUpgradeSuccessView, {
            userId = if localPlayer then localPlayer.UserId else 0,
            displayName = var9.displayName,
            username = var9.username,
            didUsernameChange = var9.didUsernameChange,
            linkedAccountType = FStringAccountUpgradeLinkedAccountType,
            onRespawnNow = onRespawnNow,
            onApplyLater = var6,
            onConfirm = var6,
            hasBackdrop = true
        })
    else
        element = React.createElement(AccountUpgradeContainer, {
            flow = tbl1.flow,
            hasBackdrop = true,
            currentUsername = localPlayerName,
            onClose = tbl1.onDismiss,
            onSignUpComplete = onSignUpComplete
        })
    end

    return React.createElement(CoreScriptsRootProvider, {}, {
        ModalFix = React.createElement("ImageButton", { BackgroundTransparency = 1, Modal = true, Size = UDim2.fromOffset(0, 0) }),
        Overlay = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2,
                ref = ref
            }
        ),
        Content = if gui then React.createElement(
            Foundation.OverlayProvider,
            { gui = gui },
            {
                Providers = React.createElement(InExperienceProviderContainer, {}, element)
            }
        ) else nil
    })
end

return AccountUpgradePromptApp
