-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local InExperienceTransferFlow = require(CurrencyTransfers.Flows.InExperienceTransferFlow)
local InExperienceTransferUpsellApp = require(CurrencyTransfers.Components.InExperienceTransferUpsellApp)
local useInExperienceTransferListenerEffect = require(CurrencyTransfers.Hooks.useInExperienceTransferListenerEffect)

local function InExperienceTransferApp()
    local initiateResponse, var2 = React.useState(nil)

    local var3 = React.useCallback(function(arg1)
        var2(function(arg2)
            return if arg2 == nil then arg1 else arg2
        end)
    end, {})

    local onClose = React.useCallback(function()
        var2(nil)
    end, {})

    useInExperienceTransferListenerEffect(var3)

    local inExperienceTransferFlow = React.useMemo(function()
        if initiateResponse == nil then
            return nil
        end
        return InExperienceTransferFlow({ initiateResponse = initiateResponse, onClose = onClose })
    end, { initiateResponse, onClose })

    local upsellApp = if SharedFlags.GetEngineFeatureEnablePromptRobuxTransferDedicatedUpsellEvent() then React.createElement(InExperienceTransferUpsellApp) else nil
    local flowScreen = if inExperienceTransferFlow then React.createElement(
        "ScreenGui",
        {
            ScreenInsets = Enum.ScreenInsets.None,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            DisplayOrder = 8
        },
        { InExperienceTransferFlow = inExperienceTransferFlow }
    ) else nil

    if not (flowScreen or upsellApp) then
        return nil
    elseif not upsellApp then
        return flowScreen
    end

    return React.createElement(React.Fragment, nil, { FlowScreen = flowScreen, UpsellApp = upsellApp })
end

return InExperienceTransferApp
