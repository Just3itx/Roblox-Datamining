-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local React = require(CorePackages.Packages.React)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local mutedError = require(CorePackages.Workspace.Packages.Loggers).mutedError

local scriptParentParent = script.Parent.Parent
local BasePublishPrompt = require(scriptParentParent.BasePublishPrompt)
local ObjectViewport = require(scriptParentParent.Common.ObjectViewport)
local LabeledTextBox = require(scriptParentParent.Common.LabeledTextBox)
local PublishInfoList = require(scriptParentParent.Common.PublishInfoList)
local PurchasePrompt = require(CorePackages.Workspace.Packages.PurchasePrompt)
local PublishAssetAnalytics = PurchasePrompt.PublishAssetAnalytics

local scriptParentParentParent = scriptParentParent.Parent

local Actions = scriptParentParentParent.Actions
local SetPromptVisibility = require(Actions.SetPromptVisibility)

local RoactUtils = require(CorePackages.Workspace.Packages.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local Constants = require(scriptParentParentParent.Constants)
local MakeupPreviewUtils = require(scriptParentParentParent.MakeupPreviewUtils)
local MakeupPartGrid = require(scriptParentParent.Common.MakeupPartGrid)

local GetFFlagSingleUploadMakeupSupport = require(scriptParentParentParent.Flags.GetFFlagSingleUploadMakeupSupport)

local uDim = UDim.new(0, 20)

local function PublishAvatarAssetPrompt(tbl1)
    local localPlayer = Players.LocalPlayer
    assert(localPlayer, "LocalPlayer must not be nil")

    local var1 = useSelector(function(arg1)
        return arg1.promptRequest.promptInfo
    end)

    local var2 = useDispatch()

    local var3 = Constants.AvatarAssetTypeDefaultName[var1.accessoryType]
    local var4 = localPlayer.Name .. "'s " .. var3

    local showingPreviewView, var6 = React.useState(false)
    local var7, var8 = React.useState(var4)
    local var9, var10 = React.useState(true)
    local var11, var12 = React.useState(var4)
    local var13, var14 = React.useState(true)
    local showTopScrim, var16 = React.useState(false)
    local var17, var18 = React.useState(true)
    local isMakeupPreview = if GetFFlagSingleUploadMakeupSupport() then MakeupPreviewUtils.isMakeupAssetType(var1.accessoryType) else false
    local var20, var21 = React.useState(nil)

    React.useEffect(function()
        if not (isMakeupPreview and var1.accessoryInstance) then
            return function() end
        end

        local makeupHeadPreview = MakeupPreviewUtils.createMakeupHeadPreview(var1.accessoryInstance, var1.accessoryType)
        var21(makeupHeadPreview)

        return function()
            if makeupHeadPreview then
                makeupHeadPreview:Destroy()
            end
        end
    end, { var1.accessoryInstance, isMakeupPreview, var1.accessoryType })

    if not isMakeupPreview then
        var20 = var1.accessoryInstance
    end

    local var22 = React.useRef(false)
    local var23 = React.useRef(false)
    local var24 = React.useRef(nil)
    local var25 = React.useRef(nil)

    local openPreviewView = React.useCallback(function()
        PublishAssetAnalytics.sendButtonClicked(
            PublishAssetAnalytics.Section.BuyCreationPage,
            PublishAssetAnalytics.Element.Expand
        )
        var6(true)
    end, {})

    local closePreviewView = React.useCallback(function()
        var6(false)
    end, {})

    local canSubmit = React.useCallback(function()
        local var28 = var9 and var13
        return var28 and var1.accessoryInstance ~= nil and var17
    end, {
        var9,
        var13,
        var1.accessoryInstance,
        var17
    })
    local onSubmit = React.useCallback(function()
        PublishAssetAnalytics.sendButtonClicked(
            PublishAssetAnalytics.Section.BuyCreationPage,
            PublishAssetAnalytics.Element.Buy
        )
        local tbl2 = { name = var7, description = var11 }

        if PurchasePrompt.initiateAvatarCreationFeePurchase then
            PurchasePrompt.initiateAvatarCreationFeePurchase(tbl2, var1.guid, var20, var1.priceInRobux)
            return
        end

        mutedError("PurchasePrompt.initiateAvatarCreationFeePurchase is not available")
    end, {
        var7,
        var11,
        var1.guid,
        var1.accessoryInstance,
        var1.priceInRobux,
        var20
    })

    local onNameUpdated = React.useCallback(function(arg1, arg2)
        var8(arg1)
        var10(arg2)

        if not var22.current then
            var22.current = true
            PublishAssetAnalytics.sendFieldTouched(
                PublishAssetAnalytics.Section.BuyCreationPage,
                PublishAssetAnalytics.Element.Name
            )
        end
    end, {})

    local onTextUpdated = React.useCallback(function(arg1, arg2)
        var12(arg1)
        var14(arg2)

        if not var23.current then
            var23.current = true
            PublishAssetAnalytics.sendFieldTouched(
                PublishAssetAnalytics.Section.BuyCreationPage,
                PublishAssetAnalytics.Element.Description
            )
        end
    end, {})

    local function func1(arg1)
        local hasCompletedPurchase = arg1.hasCompletedPurchase
        local isShown = arg1.isShown

        if hasCompletedPurchase and not isShown then
            var2(SetPromptVisibility(false))
            return
        end
        var16(isShown)
        if isShown then
            var18(false)
        end
    end

    local function func2()
        var18(true)
    end

    React.useEffect(function()
        local windowStateChangedEvent = PurchasePrompt.windowStateChangedEvent
        local promptStateSetToNoneEvent = PurchasePrompt.promptStateSetToNoneEvent

        if windowStateChangedEvent and promptStateSetToNoneEvent then
            var24.current = windowStateChangedEvent:Connect(func1)
            var25.current = promptStateSetToNoneEvent:Connect(func2)
        else
            mutedError("PurchasePrompt.windowStateChangedEvent or PurchasePrompt.promptStateSetToNoneEvent is not available")
        end

        PublishAssetAnalytics.sendPageLoad(PublishAssetAnalytics.Section.BuyCreationPage)

        return function()
            if var24.current then
                var24.current:Disconnect()
                var24.current = nil
            else
                mutedError("windowStateChangedConnection was not established")
            end
            if var25.current then
                var25.current:Disconnect()
                var25.current = nil
                return
            end
            mutedError("promptStateSetToNoneConnection was not established")
        end
    end, {})

    local typeName = (if isMakeupPreview then RobloxTranslator:FormatByKey("Feature.Catalog.Label.Makeup") else RobloxTranslator:FormatByKey("Feature.Avatar.Label.Accessory"))
        .. " | " .. RobloxTranslator:FormatByKey(Constants.AvatarAssetTypeLocalized[var1.accessoryType])

    local useCallback = React.useCallback
    local function func3()
        local isLoading = var20 == nil
        return React.createElement(React.Fragment, nil, {
            UIListLayout = React.createElement("UIListLayout", {
                Padding = uDim,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical
            }),
            UIPadding = React.createElement("UIPadding", { PaddingBottom = uDim, PaddingTop = uDim }),
            EmbeddedPreview = React.createElement(ObjectViewport, {
                openPreviewView = openPreviewView,
                model = var20,
                isLoading = isLoading,
                useFullBodyCameraSettings = not (GetFFlagSingleUploadMakeupSupport() and isMakeupPreview),
                fieldOfView = 30,
                LayoutOrder = 1,
                isMakeupPreview = isMakeupPreview
            }),
            DescriptionInput = React.createElement(LabeledTextBox, {
                LayoutOrder = 2,
                labelText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Description"),
                centerText = false,
                defaultText = var11,
                maxLength = 1000,
                onTextUpdated = onTextUpdated,
                textBoxHeight = 104,
                invalidInputText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.InvalidDescription")
            }),
            InfoList = React.createElement(PublishInfoList, { typeName = typeName, LayoutOrder = 3 }),
            MakeupGrid = isMakeupPreview
                and React.createElement(MakeupPartGrid, {
                    singleDecal = var1.accessoryInstance,
                    singleAssetType = var1.accessoryType,
                    makeupEntries = {{
                        assetType = var1.accessoryType,
                        sortOrder = 1
                    }},
                    showAssetTypeInLabel = false,
                    name = var7,
                    LayoutOrder = 4,
                    screenSize = tbl1.screenSize
                })
                or nil
        })
    end

    local accessoryType = var1.accessoryType
    local var33 = if isMakeupPreview then var7 else nil
    local var34 = useCallback(func3, { var20, accessoryType, var11, var33, isMakeupPreview, typeName })

    return React.createElement(BasePublishPrompt, {
        promptBody = var34(),
        screenSize = tbl1.screenSize,
        showingPreviewView = showingPreviewView,
        closePreviewView = closePreviewView,
        isMakeupPreview = isMakeupPreview,
        asset = var20,
        nameLabel = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Name"),
        defaultName = var7,
        titleText = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.BuyCreation"),
        onNameUpdated = onNameUpdated,
        canSubmit = canSubmit,
        onSubmit = onSubmit,
        delayInputSeconds = 3,
        priceInRobux = var1.priceInRobux,
        showTopScrim = showTopScrim
    })
end

return PublishAvatarAssetPrompt
