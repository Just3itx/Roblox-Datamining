-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local mutedError = require(CorePackages.Workspace.Packages.Loggers).mutedError

local scriptParentParent = script.Parent.Parent
local BasePublishPrompt = require(scriptParentParent.BasePublishPrompt)
local ObjectViewport = require(scriptParentParent.Common.ObjectViewport)
local LabeledTextBox = require(scriptParentParent.Common.LabeledTextBox)
local PublishInfoList = require(scriptParentParent.Common.PublishInfoList)
local MakeupPartGrid = require(scriptParentParent.Common.MakeupPartGrid)
local MakeupPreviewUtils = require(script.Parent.Parent.Parent.MakeupPreviewUtils)
local GetFFlagUploadMakeupSupport = require(script.Parent.Parent.Parent.Flags.GetFFlagUploadMakeupSupport)
local PurchasePrompt = require(CorePackages.Workspace.Packages.PurchasePrompt)
local PublishAssetAnalytics = PurchasePrompt.PublishAssetAnalytics

local Actions = script.Parent.Parent.Parent.Actions
local SetPromptVisibility = require(Actions.SetPromptVisibility)

local uDim = UDim.new(0, 20)

local var1 = Roact.PureComponent:extend("PublishMakeupLookPrompt")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    accessoryInstance = t.optional(t.union(t.instanceIsA("Folder"), t.instanceIsA("Decal"))),
    makeupEntries = t.optional(t.table),
    guid = t.any,
    scopes = t.any,
    priceInRobux = t.optional(t.number),
    SetPromptVisibility = t.callback
})

function var1.init(arg1)
    local localPlayer = Players.LocalPlayer
    assert(localPlayer, "LocalPlayer must not be nil")

    arg1:setState({
        showingPreviewView = false,
        name = localPlayer.Name .. "'s Makeup",
        isNameValid = true,
        description = localPlayer.Name .. "'s Makeup",
        isDescValid = true,
        showTopScrim = false,
        purchasePromptReady = true,
        previewModel = nil
    })

    function arg1.openPreviewView()
        PublishAssetAnalytics.sendButtonClicked(
            PublishAssetAnalytics.Section.BuyCreationPage,
            PublishAssetAnalytics.Element.Expand
        )
        arg1:setState({ showingPreviewView = true })
    end

    function arg1.closePreviewView()
        arg1:setState({ showingPreviewView = false })
    end

    function arg1.canSubmit()
        local isDescValid = arg1.state.isNameValid and arg1.state.isDescValid
        return isDescValid and arg1.props.accessoryInstance ~= nil and arg1.state.purchasePromptReady
    end

    function arg1.onSubmit()
        PublishAssetAnalytics.sendButtonClicked(
            PublishAssetAnalytics.Section.BuyCreationPage,
            PublishAssetAnalytics.Element.Buy
        )
        local tbl1 = {
            name = arg1.state.name,
            description = arg1.state.description
        }

        if PurchasePrompt.initiateAvatarCreationFeePurchase then
            PurchasePrompt.initiateAvatarCreationFeePurchase(
                tbl1,
                arg1.props.guid,
                arg1.state.previewModel,
                arg1.props.priceInRobux
            )
            return
        end

        mutedError("PurchasePrompt.initiateAvatarCreationFeePurchase is not available")
    end

    function arg1.onNameUpdated(name, isNameValid)
        arg1:setState({ name = name, isNameValid = isNameValid })
        if not arg1.sentNameFieldTouched then
            arg1.sentNameFieldTouched = true
            PublishAssetAnalytics.sendFieldTouched(
                PublishAssetAnalytics.Section.BuyCreationPage,
                PublishAssetAnalytics.Element.Name
            )
        end
    end
    function arg1.onDescriptionUpdated(description, isDescValid)
        arg1:setState({ description = description, isDescValid = isDescValid })
        if not arg1.sentDescriptionFieldTouched then
            arg1.sentDescriptionFieldTouched = true
            PublishAssetAnalytics.sendFieldTouched(
                PublishAssetAnalytics.Section.BuyCreationPage,
                PublishAssetAnalytics.Element.Description
            )
        end
    end
    function arg1.onWindowStateChanged(arg2)
        local hasCompletedPurchase = arg2.hasCompletedPurchase
        local isShown = arg2.isShown

        if hasCompletedPurchase and not isShown then
            arg1.props.SetPromptVisibility(false)
            return
        end
        arg1:setState({ showTopScrim = isShown })
        if isShown then
            arg1:setState({ purchasePromptReady = false })
        end
    end

    function arg1.onPromptStateSetToNone()
        arg1:setState({ purchasePromptReady = true })
    end
end

function var1.updatePreviewModel(arg1)
    local accessoryInstance = arg1.props.accessoryInstance
    if not (accessoryInstance and accessoryInstance:IsA("Folder")) then
        return
    end

    local makeupEntries = arg1.props.makeupEntries

    task.spawn(function()
        local var2 = MakeupPreviewUtils.compositeMakeupFolder(accessoryInstance)
        local folderAccessories = MakeupPreviewUtils.getFolderAccessories(accessoryInstance, makeupEntries)
        if not var2 and #folderAccessories == 0 or not arg1.isMounted then
            return
        end

        local previewModel = MakeupPreviewUtils.createMakeupHeadPreview(var2, Enum.AvatarAssetType.FaceMakeup, folderAccessories)
        if not previewModel or not arg1.isMounted then
            return
        end

        local previewModel2 = arg1.state.previewModel
        arg1:setState({ previewModel = previewModel }, function()
            if previewModel2 then
                previewModel2:Destroy()
            end
        end)
    end)
end

function var1.didMount(arg1)
    arg1.isMounted = true
    arg1:updatePreviewModel()
    arg1.sentNameFieldTouched = false
    arg1.sentDescriptionFieldTouched = false

    local windowStateChangedEvent = PurchasePrompt.windowStateChangedEvent
    local promptStateSetToNoneEvent = PurchasePrompt.promptStateSetToNoneEvent

    if windowStateChangedEvent and promptStateSetToNoneEvent then
        arg1.windowStateChangedConnection = windowStateChangedEvent:Connect(arg1.onWindowStateChanged)
        arg1.promptStateSetToNoneConnection = promptStateSetToNoneEvent:Connect(arg1.onPromptStateSetToNone)
    else
        mutedError("PurchasePrompt.windowStateChangedEvent or PurchasePrompt.promptStateSetToNoneEvent is not available")
    end

    PublishAssetAnalytics.sendPageLoad(PublishAssetAnalytics.Section.BuyCreationPage)
end

function var1.didUpdate(arg1, arg2)
    if arg2.accessoryInstance ~= arg1.props.accessoryInstance then
        arg1:updatePreviewModel()
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false

    if arg1.state.previewModel then
        arg1.state.previewModel:Destroy()
    end

    if arg1.windowStateChangedConnection then
        arg1.windowStateChangedConnection:Disconnect()
    else
        mutedError("windowStateChangedConnection was not established")
    end

    if arg1.promptStateSetToNoneConnection then
        arg1.promptStateSetToNoneConnection:Disconnect()
        return
    end
    mutedError("promptStateSetToNoneConnection was not established")
end

function var1.renderPromptBody(arg1)
    local previewModel = arg1.state.previewModel
    return Roact.createFragment({
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = uDim,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical
        }),
        UIPadding = Roact.createElement("UIPadding", { PaddingBottom = uDim, PaddingTop = uDim }),
        EmbeddedPreview = Roact.createElement(ObjectViewport, {
            openPreviewView = arg1.openPreviewView,
            model = previewModel,
            isLoading = previewModel == nil,
            useFullBodyCameraSettings = false,
            fieldOfView = 30,
            LayoutOrder = 1,
            isMakeupPreview = GetFFlagUploadMakeupSupport()
        }),
        DescriptionInput = Roact.createElement(LabeledTextBox, {
            LayoutOrder = 2,
            labelText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Description"),
            centerText = false,
            defaultText = arg1.state.description,
            maxLength = 1000,
            onTextUpdated = arg1.onDescriptionUpdated,
            textBoxHeight = 104,
            invalidInputText = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.InvalidDescription")
        }),
        InfoList = Roact.createElement(
            PublishInfoList,
            {
                typeName = RobloxTranslator:FormatByKey("Feature.Catalog.Label.Makeup"),
                LayoutOrder = 3
            }
        ),
        MakeupGrid = Roact.createElement(MakeupPartGrid, {
            makeupFolder = arg1.props.accessoryInstance,
            makeupEntries = arg1.props.makeupEntries,
            name = arg1.state.name,
            LayoutOrder = 4,
            screenSize = arg1.props.screenSize
        })
    })
end

function var1.render(arg1)
    return Roact.createElement(BasePublishPrompt, {
        promptBody = arg1:renderPromptBody(),
        screenSize = arg1.props.screenSize,
        showingPreviewView = arg1.state.showingPreviewView,
        closePreviewView = arg1.closePreviewView,
        isMakeupPreview = GetFFlagUploadMakeupSupport(),
        asset = arg1.state.previewModel,
        nameLabel = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Name"),
        defaultName = arg1.state.name,
        titleText = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.BuyCreation"),
        onNameUpdated = arg1.onNameUpdated,
        canSubmit = arg1.canSubmit,
        onSubmit = arg1.onSubmit,
        delayInputSeconds = 3,
        priceInRobux = arg1.props.priceInRobux,
        showTopScrim = arg1.state.showTopScrim
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        accessoryInstance = arg1.promptRequest.promptInfo.accessoryInstance,
        guid = arg1.promptRequest.promptInfo.guid,
        scopes = arg1.promptRequest.promptInfo.scopes,
        priceInRobux = arg1.promptRequest.promptInfo.priceInRobux,
        makeupEntries = arg1.promptRequest.promptInfo.makeupEntries
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        SetPromptVisibility = function(arg1)
            callback(SetPromptVisibility(arg1))
        end
    }
end)(var1)
