-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ExperienceAuthService = game:GetService("ExperienceAuthService")
local Players = game:GetService("Players")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local UIBlox = require(CorePackages.Packages.UIBlox)
local normalizeFontFace = require(CorePackages.Packages.Foundation).Utility.normalizeFontFace
local withStyle = UIBlox.Style.withStyle
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)

local LocalPlayer = Players.LocalPlayer

local NameTextBox = require(script.Parent.Common.NameTextBox)
local AssetDescriptionTextBox = require(script.Parent.AssetDescriptionTextBox)
local ImagePreview = require(script.Parent.ImagePreview)
local ObjectViewport = require(script.Parent.ObjectViewport)
local CloseOpenPrompt = require(script.Parent.Parent.Actions.CloseOpenPrompt)

local tbl1 = {
    [Enum.AssetType.TShirtAccessory] = true,
    [Enum.AssetType.ShirtAccessory] = true,
    [Enum.AssetType.PantsAccessory] = true,
    [Enum.AssetType.JacketAccessory] = true,
    [Enum.AssetType.SweaterAccessory] = true,
    [Enum.AssetType.ShortsAccessory] = true,
    [Enum.AssetType.LeftShoeAccessory] = true,
    [Enum.AssetType.RightShoeAccessory] = true,
    [Enum.AssetType.DressSkirtAccessory] = true,
    [Enum.AssetType.HairAccessory] = true
}

local bool1 = game:DefineFastFlag("SendConsentDeniedOnCancel", false)

local FFlagDisablePublishPlatformContentWithoutName = require(script.Parent.Parent.Flags.FFlagDisablePublishPlatformContentWithoutName)
local engineFeature = game:GetEngineFeature("EnableImagePublish")

local var1 = Roact.PureComponent:extend("PublishAssetPromptSingleStep")

var1.validateProps = t.strictInterface({
    screenSize = t.Vector2,
    assetInstance = t.Instance,
    assetType = t.enum(Enum.AssetType),
    guid = t.any,
    scopes = t.any,
    closePrompt = t.callback
})

function var1.getDefaultText(arg1)
    if arg1.props.assetType == Enum.AssetType.Model then
        return RobloxTranslator:FormatByKey(
            "CoreScripts.PublishAssetPrompt.PackagesDefaultName",
            {
                RBX_NAME = LocalPlayer and LocalPlayer.Name or ""
            }
        )
    end

    return ""
end

function var1.init(arg1)
    arg1.assetName = arg1:getDefaultText()
    arg1.assetDescription = arg1:getDefaultText()

    arg1.isNameValid = true

    if FFlagDisablePublishPlatformContentWithoutName then
        arg1.defaultName = arg1.assetName

        arg1:setState({ isPublishNameValid = string.match(arg1.assetName, "^%s*$") == nil })
    end

    function arg1.closePrompt()
        arg1.props.closePrompt()
    end

    function arg1.denyAndClose()
        ExperienceAuthService:ScopeCheckUIComplete(arg1.props.guid, arg1.props.scopes, Enum.ScopeCheckResult.ConsentDenied, {})

        arg1.closePrompt()
    end

    function arg1.confirmAndUpload()
        if not (if FFlagDisablePublishPlatformContentWithoutName then arg1.state.isPublishNameValid else arg1.isNameValid) then
            return
        end

        local metadata = ({})
        metadata.assetName = arg1.assetName
        metadata.assetDescription = arg1.assetDescription

        ExperienceAuthService:ScopeCheckUIComplete(
            arg1.props.guid,
            arg1.props.scopes,
            Enum.ScopeCheckResult.ConsentAccepted,
            metadata
        )

        arg1.closePrompt()
    end

    function arg1.onAssetNameUpdated(assetName, isPublishNameValid)
        if FFlagDisablePublishPlatformContentWithoutName then
            if isPublishNameValid then
                arg1.assetName = assetName
            end
            arg1:setState({ isPublishNameValid = isPublishNameValid })
        elseif isPublishNameValid then
            arg1.assetName = assetName
            arg1.isNameValid = true
        else
            arg1.isNameValid = false
        end
    end

    function arg1.onAssetDescriptionUpdated(assetDescription)
        arg1.assetDescription = assetDescription
    end

    arg1.nameTextBoxRef = Roact.createRef()
    arg1.descriptionTextBoxRef = Roact.createRef()
end

function var1.renderMiddle(arg1, arg2)
    return withStyle(function(arg3)
        local theme = arg3.Theme

        local bool2 = engineFeature

        if bool2 then
            if arg1.props.assetType == Enum.AssetType.Image then
                bool2 = arg1.props.assetInstance:IsA("Decal")
            else
                bool2 = false
            end
        end

        local createElement = Roact.createElement
        local frame = RoactGamepad.Focusable.Frame
        local tbl2 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 150),
            defaultChild = arg1.nameTextBoxRef,
            [Roact.Ref] = arg1.middleContentRef
        }
        local tbl3 = {
            UISizeConstraint = Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(200, 200) }),
            TopSection = 0,
            Disclaimer = 0
        }
        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = UDim2.new(1, 0, 1, -50),
            BackgroundTransparency = 1
        }
        local tbl5 = {
            ViewportParent = Roact.createElement("Frame", {
                Size = UDim2.new(0.4, 0, 1, 0),
                BackgroundTransparency = 1
            }, {
                ImagePreview = if bool2 then Roact.createElement(ImagePreview, { imageContent = arg1.props.assetInstance.TextureContent, autoRotateSeconds = 6 }) else nil,
                ObjectViewport = if bool2 then nil else Roact.createElement(ObjectViewport, { model = arg1.props.assetInstance }) or nil
            }),
            NameDescriptionFields = 0
        }

        local createElement3 = Roact.createElement
        local str2 = "Frame"
        local tbl6 = {
            Size = UDim2.new(0.6, -10, 1, 0),
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromScale(1, 0),
            BackgroundTransparency = 1
        }
        local tbl7 = {
            NameLabel = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 15),
                FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
                Text = arg2.name,
                TextSize = 12,
                TextColor3 = theme.TextDefault.Color,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            NameInput = Roact.createElement(NameTextBox, {
                Size = UDim2.new(1, 0, 0, 30),
                Position = UDim2.new(0, 0, 0, 15),
                onNameUpdated = arg1.onAssetNameUpdated,
                nameTextBoxRef = arg1.nameTextBoxRef,
                NextSelectionDown = arg1.descriptionTextBoxRef,
                defaultName = if FFlagDisablePublishPlatformContentWithoutName then arg1.defaultName else arg1.assetName
            }),
            DescriptionLabel = Roact.createElement("TextLabel", {
                Size = UDim2.new(1, 0, 0, 15),
                Position = UDim2.new(0, 0, 0, 60),
                FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
                TextSize = 12,
                Text = arg2.description,
                TextColor3 = theme.TextDefault.Color,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            DescriptionInput = Roact.createElement(AssetDescriptionTextBox, {
                Size = UDim2.new(1, 0, 0, 80),
                Position = UDim2.new(0, 0, 0, 75),
                onAssetDescriptionUpdated = arg1.onAssetDescriptionUpdated,
                descriptionTextBoxRef = arg1.descriptionTextBoxRef,
                NextSelectionUp = arg1.nameTextBoxRef,
                defaultDescription = arg1.assetDescription
            })
        }
        tbl5.NameDescriptionFields = createElement3(str2, tbl6, tbl7)
        tbl3.TopSection = createElement2(str1, tbl4, tbl5)

        tbl3.Disclaimer = Roact.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, 50),
            TextYAlignment = Enum.TextYAlignment.Center,
            Text = arg2.disclaimer,
            FontFace = normalizeFontFace(arg3.Tokens.Typography.BodyLarge.Font),
            TextSize = 12,
            TextColor3 = theme.TextEmphasis.Color,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            TextWrapped = true
        })
        return createElement(frame, tbl2, tbl3)
    end)
end

function var1.renderAlertLocalized(arg1, arg2)
    local createElement = Roact.createElement
    local var2 = InteractiveAlert
    local tbl2 = {
        title = arg2.title,
        buttonStackInfo = 0,
        middleContent = 0,
        screenSize = 0,
        defaultChildRef = 0,
        isMiddleContentFocusable = true
    }
    local buttonStackInfo = {
        buttons = {
            {
                props = {
                    onActivated = if bool1 then arg1.denyAndClose else arg1.closePrompt,
                    text = arg2.cancel
                },
                isDefaultChild = true
            },
            {
                buttonType = ButtonType.PrimarySystem,
                props = {
                    onActivated = arg1.confirmAndUpload,
                    text = arg2.submit,
                    isDelayedInput = true,
                    enableInputDelayed = true,
                    delayInputSeconds = 6,
                    isDisabled = if FFlagDisablePublishPlatformContentWithoutName then not arg1.state.isPublishNameValid else nil
                },
                isDefaultChild = false
            }
        }
    }
    tbl2.buttonStackInfo = buttonStackInfo

    function tbl2.middleContent()
        return arg1:renderMiddle(arg2)
    end
    tbl2.screenSize = arg1.props.screenSize
    tbl2.defaultChildRef = arg1.props.defaultChildRef
    return (createElement(var2, tbl2))
end

local function IsLayeredClothingType(assetType): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[assetType] == true
end

local function GetLocalizedStringsForAssetType(assetType)
    local localizedStringsForAssetType = ({})
    localizedStringsForAssetType.name = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Name")
    localizedStringsForAssetType.description = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Description")
    localizedStringsForAssetType.invalidName = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.InvalidName")
    localizedStringsForAssetType.invalidDescription = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.InvalidDescription")
    localizedStringsForAssetType.cancel = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Cancel")
    localizedStringsForAssetType.submit = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.Submit")

    if IsLayeredClothingType(assetType) then
        localizedStringsForAssetType.title = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.TitleTextClothing")
        localizedStringsForAssetType.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.DisclaimerAvatar")
        return localizedStringsForAssetType
    end

    if assetType == Enum.AssetType.EmoteAnimation then
        localizedStringsForAssetType.title = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.TitleTextEmote")
        localizedStringsForAssetType.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.DisclaimerEmote")
        return localizedStringsForAssetType
    end

    if assetType == Enum.AssetType.Model then
        localizedStringsForAssetType.title = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.TitleTextModel")
        localizedStringsForAssetType.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.DisclaimerModel")
        return localizedStringsForAssetType
    end

    if assetType == Enum.AssetType.Package then
        localizedStringsForAssetType.title = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.TitleTextPackage")
        localizedStringsForAssetType.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.DisclaimerModel")
        return localizedStringsForAssetType
    end

    if assetType == Enum.AssetType.Image then
        localizedStringsForAssetType.title = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.TitleTextImage")
        localizedStringsForAssetType.disclaimer = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.DisclaimerImage")
    end

    return localizedStringsForAssetType
end

function var1.render(arg1)
    return arg1:renderAlertLocalized((GetLocalizedStringsForAssetType(arg1.props.assetType)))
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        assetInstance = arg1.promptRequest.promptInfo.assetInstance,
        assetType = arg1.promptRequest.promptInfo.assetType,
        guid = arg1.promptRequest.promptInfo.guid,
        scopes = arg1.promptRequest.promptInfo.scopes
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closePrompt = function()
            return arg1(CloseOpenPrompt())
        end
    }
end)(var1)
