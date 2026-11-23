-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent

local React = require(AvatarExperienceInspectAndBuyParent.React)
local useSelector = require(AvatarExperienceInspectAndBuyParent.RoactUtils).Hooks.RoactRodux.useSelector
local FocusNavigationUtils = require(AvatarExperienceInspectAndBuyParent.FocusNavigationUtils)

local _Types = require(AvatarExperienceInspectAndBuy.Types)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigableSurfaceRegistry = FocusNavigationUtils.FocusNavigableSurfaceRegistry
local useRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useRegisterFocusNavigableSurface
local useDeRegisterFocusNavigableSurface = FocusNavigableSurfaceRegistry.useDeRegisterFocusNavigableSurface
local useRegistryEntry = FocusNavigableSurfaceRegistry.useRegistryEntry
local useAutoFocus = FocusNavigationUtils.useAutoFocus
local useDescendantHasFocus = FocusNavigationUtils.useDescendantHasFocus
local useLastInputMode = FocusNavigationUtils.useLastInputMode

local function selectItemBeingPurchased(arg1)
    return arg1.itemBeingPurchased
end

local function useInspectAndBuyFocusNavigation()
    local selectionParent, setFocusRef = React.useState(nil)
    local var2, var3 = React.useState(false)

    local var4 = useSelector(selectItemBeingPurchased)
    local var5 = var4 and var4.itemId ~= nil

    local var6 = useRegisterFocusNavigableSurface()
    local var7 = useDeRegisterFocusNavigableSurface()
    local var8 = useAutoFocus({ selectionParent }, 0.1)
    local var9 = useDescendantHasFocus(selectionParent)
    local bool1 = useLastInputMode() == "Focus"

    local var10 = var5 or var2

    local bool2 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.PopUp) ~= nil
    local bool3 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.ContextualMenu) ~= nil
    local bool4 = useRegistryEntry(FocusNavigableSurfaceIdentifierEnum.ModerationOverlay) ~= nil

    React.useEffect(function()
        local connection = MarketplaceService.PromptBulkPurchaseRequested:Connect(function(player: Instance)
            if player == Players.LocalPlayer then
                var3(true)
            end
        end)
        local connection2 = MarketplaceService.PromptBulkPurchaseFinished:Connect(function(player: Instance)
            if player == Players.LocalPlayer then
                var3(false)
            end
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    React.useEffect(function()
        if var10 then
            var7(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, selectionParent)
            GuiService:RemoveSelectionGroup("InspectAndBuyApp")
            return function() end
        end

        if selectionParent then
            var6(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, selectionParent)
            GuiService:AddSelectionParent("InspectAndBuyApp", selectionParent)
        else
            var7(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, selectionParent)
            GuiService:RemoveSelectionGroup("InspectAndBuyApp")
            GuiService.SelectedCoreObject = nil
        end

        return function()
            var7(FocusNavigableSurfaceIdentifierEnum.CentralOverlay, selectionParent)
            GuiService:RemoveSelectionGroup("InspectAndBuyApp")
            GuiService.SelectedCoreObject = nil
        end
    end, {
        selectionParent,
        var10,
        var7,
        var6
    })

    local var11 = bool1 and selectionParent and not (var9 or var10 or bool2 or bool3 or bool4)

    React.useEffect(function()
        local var12 = if var11 then var8() else nil

        return function()
            if var12 then
                var12.cancel()
            end
        end
    end, { var11, var8 })

    return {
        setFocusRef = setFocusRef,
        focusNavigationProps = {
            SelectionGroup = true,
            SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
            SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
            SelectionBehaviorRight = Enum.SelectionBehavior.Stop,
            SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        }
    }
end

return useInspectAndBuyFocusNavigation
