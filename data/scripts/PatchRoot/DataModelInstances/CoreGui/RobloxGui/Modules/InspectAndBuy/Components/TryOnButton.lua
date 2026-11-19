-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local scriptParentParent = script.Parent.Parent
local Colors = require(scriptParentParent.Colors)
local Constants = require(scriptParentParent.Constants)
local SetTryingOnInfo = require(scriptParentParent.Actions.SetTryingOnInfo)
local TryOnItem = require(scriptParentParent.Thunks.TryOnItem)
local getSelectionImageObjectRounded = require(scriptParentParent.getSelectionImageObjectRounded)

local TryOn = require(script.Parent.Common.ControllerShortcutKeycodes).TryOn

local var1 = Roact.PureComponent:extend("TryOnButton")

function var1.init(arg1)
    arg1.selectedImage = getSelectionImageObjectRounded()

    ContextActionService:BindCoreAction("TryOnGamepadShortcut", function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.End then
            return Enum.ContextActionResult.Pass
        end

        arg1:activateButton()
        return Enum.ContextActionResult.Sink
    end, false, TryOn)
end

function var1.activateButton(arg1)
    if not arg1.props.showTryOn then
        return
    end

    local assetInfo = arg1.props.assetInfo
    local tryOnItem = arg1.props.tryOnItem
    local takeOffItem = arg1.props.takeOffItem
    local tryingOn = arg1.props.tryingOnInfo.tryingOn
    local partOfBundleAndOffsale = arg1.props.partOfBundleAndOffsale
    local bundleId = arg1.props.bundleId

    local localPlayerModel = assetInfo and arg1.props.localPlayerModel

    if localPlayerModel then
        if Constants.LayeredAssetTypes[assetInfo.assetTypeId] == nil then
            localPlayerModel = false
        else
            localPlayerModel = arg1.props.localPlayerModel.Humanoid.RigType == Enum.HumanoidRigType.R6
        end
    end

    if localPlayerModel then
        return
    end

    if tryingOn then
        takeOffItem()
        return
    end
    tryOnItem(true, assetInfo.assetId, assetInfo.assetTypeId, partOfBundleAndOffsale, bundleId)
end

function var1.willUnmount(_)
    ContextActionService:UnbindCoreAction("TryOnGamepadShortcut")
end

function var1.render(arg1)
    local tryingOn = arg1.props.tryingOnInfo.tryingOn
    local showTryOn = arg1.props.showTryOn
    local locale = arg1.props.locale
    local assetInfo = arg1.props.assetInfo
    local tryOnButtonRef = arg1.props.tryOnButtonRef

    local str1 = if tryingOn then "InGame.InspectMenu.Action.TakeOff" else "InGame.InspectMenu.Action.TryOn"

    local localPlayerModel = assetInfo and arg1.props.localPlayerModel

    if localPlayerModel then
        if Constants.LayeredAssetTypes[assetInfo.assetTypeId] == nil then
            localPlayerModel = false
        else
            localPlayerModel = arg1.props.localPlayerModel.Humanoid.RigType == Enum.HumanoidRigType.R6
        end
    end

    local createElement = Roact.createElement
    local tbl1 = {
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, -32, 0, 44),
        Visible = showTryOn,
        LayoutOrder = 2,
        Image = "rbxasset://textures/ui/InspectMenu/Button_outline.png",
        ImageTransparency = if localPlayerModel then 0.5 else 0,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(5, 5, 120, 20)
    }
    local tbl2 = {
        SelectionGainedImage = Roact.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            Image = "rbxasset://textures/ui/InspectMenu/Button_white.png",
            ImageColor3 = Colors.Pumice
        }),
        TryOnTextKey = 0
    }
    local createElement2 = Roact.createElement
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = RobloxTranslator:FormatByKeyForLocale(str1, locale),
        Font = AppFonts.default:getDefault(),
        TextSize = 16,
        TextColor3 = Colors.White,
        TextTransparency = if localPlayerModel then 0.5 else 0,
        SelectionImageObject = arg1.selectedImage,
        ZIndex = 2
    }

    tbl3[Roact.Event.SelectionGained] = function(arg2)
        arg2.Parent.SelectionGainedImage.Visible = true
        arg2.TextColor3 = Colors.Carbon
    end
    tbl3[Roact.Event.SelectionLost] = function(arg2)
        arg2.Parent.SelectionGainedImage.Visible = false
        arg2.TextColor3 = Colors.White
    end
    tbl3[Roact.Ref] = tryOnButtonRef
    tbl3[Roact.Event.Activated] = function()
        arg1:activateButton()
    end

    tbl2.TryOnTextKey = createElement2("TextButton", tbl3)
    return createElement("ImageLabel", tbl1, tbl2)
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    local assetId = arg1.detailsInformation.assetId

    return {
        locale = arg1.locale,
        view = arg1.view,
        assetInfo = arg1.assets[assetId],
        bundleInfo = arg1.bundles,
        tryingOnInfo = arg1.tryingOnInfo
    }
end, function(callback)
    return {
        tryOnItem = function(arg1, arg2, arg3, arg4, arg5)
            callback(TryOnItem(arg1, arg2, arg3, arg4, arg5))
        end,
        takeOffItem = function()
            callback(SetTryingOnInfo(false, nil, nil))
        end
    }
end)(var1)
