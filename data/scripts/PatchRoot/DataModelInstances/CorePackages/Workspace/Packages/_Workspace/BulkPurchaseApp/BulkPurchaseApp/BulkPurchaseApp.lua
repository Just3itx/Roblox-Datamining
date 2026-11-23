-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useSelector = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector
local FocusNavigableSurfaceIdentifierEnum = require(BulkPurchaseAppParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local BulkPurchasePromptStateEnum = require(BulkPurchaseApp.Enums.BulkPurchasePromptStateEnum)

local BulkPurchaseErrorContainer = require(BulkPurchaseApp.Features.BulkPurchaseError.BulkPurchaseErrorContainer)
local BulkPurchaseSuccessContainer = require(BulkPurchaseApp.Features.BulkPurchaseSuccess.BulkPurchaseSuccessContainer)

local BulkPurchasePartialSuccessContainer = require(BulkPurchaseApp.Features.BulkPurchasePartialSuccess.BulkPurchasePartialSuccessContainer)
local BulkPurchaseRequestContainer = require(BulkPurchaseApp.Features.BulkPurchaseRequest.BulkPurchaseRequestContainer)
local ScreenSizeContext = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).ScreenSizeContext
local useBulkPurchaseRequestListenerEffect = require(BulkPurchaseApp.Hooks.useBulkPurchaseRequestListenerEffect)
local useFocusNavigationSurface = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).useFocusNavigationSurface
local FocusNavigationModalSurface = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).FocusNavigationModalSurface
local selectPromptState = require(BulkPurchaseApp.Store.Selectors.selectPromptState)
local bool1 = game:DefineFastFlag("FixBulkPurchaseInputPerf", false)

local function BulkPurchaseApp2()
    local value, var2 = React.useState(Vector2.new(0, 0))
    local var3 = useSelector(selectPromptState)
    local var4 = if bool1 then nil else useFocusNavigationSurface({
        selectionGroupName = "BulkPurchaseApp",
        focusNavigableSurfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay
    })
    useBulkPurchaseRequestListenerEffect()

    React.useEffect(function()
        if var3 == BulkPurchasePromptStateEnum.None then
            GuiService.SelectedCoreObject = nil
        end
    end, { var3 })

    local createElement = React.createElement
    local provider = ScreenSizeContext.Provider
    local tbl1 = { value = value }
    local createElement2 = React.createElement
    local str1 = "ScreenGui"
    local tbl2 = {}
    tbl2[React.Change.AbsoluteSize] = function(arg1)
        var2(arg1.AbsoluteSize)
    end
    tbl2.ScreenInsets = Enum.ScreenInsets.None
    local tbl3 = { FocusNavigationEffects = 0 }
    local element

    if bool1 then
        if var3 == BulkPurchasePromptStateEnum.None then
            element = nil
        else
            element = React.createElement(FocusNavigationModalSurface, {
                selectionGroupName = "BulkPurchaseApp"
            }, {
                Error = if var3 == BulkPurchasePromptStateEnum.Error then React.createElement(BulkPurchaseErrorContainer) else nil,
                Success = if var3 == BulkPurchasePromptStateEnum.Success then React.createElement(BulkPurchaseSuccessContainer) else nil,
                Request = if var3 == BulkPurchasePromptStateEnum.Request then React.createElement(BulkPurchaseRequestContainer) else nil,
                PartialSuccess = if var3 == BulkPurchasePromptStateEnum.PartialSuccess then React.createElement(BulkPurchasePartialSuccessContainer) else nil
            })
        end
    else
        local createElement3 = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            ref = 0,
            Size = 0,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            SelectionBehaviorDown = 0,
            SelectionBehaviorLeft = 0,
            SelectionBehaviorRight = 0,
            SelectionBehaviorUp = 0
        }

        if var3 == BulkPurchasePromptStateEnum.None then
            var4 = nil
        end

        tbl4.ref = var4
        tbl4.Size = UDim2.fromScale(1, 1)

        tbl4.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
        tbl4.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
        tbl4.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
        tbl4.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
        element = createElement3(str2, tbl4, {
            Error = if var3 == BulkPurchasePromptStateEnum.Error then React.createElement(BulkPurchaseErrorContainer) else nil,
            Success = if var3 == BulkPurchasePromptStateEnum.Success then React.createElement(BulkPurchaseSuccessContainer) else nil,
            Request = if var3 == BulkPurchasePromptStateEnum.Request then React.createElement(BulkPurchaseRequestContainer) else nil,
            PartialSuccess = if var3 == BulkPurchasePromptStateEnum.PartialSuccess then React.createElement(BulkPurchasePartialSuccessContainer) else nil
        })
    end

    tbl3.FocusNavigationEffects = element
    return createElement(provider, tbl1, createElement2(str1, tbl2, tbl3))
end

return BulkPurchaseApp2
