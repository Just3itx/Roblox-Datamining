-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local LoadableImage = UIBlox.App.Loading.LoadableImage

local scriptParentParentParent = script.Parent.Parent.Parent

local PerformSetFavorite = require(scriptParentParentParent.Thunks.PerformSetFavorite)
local SignalSetFavoritePermissionDenied = require(scriptParentParentParent.Thunks.SignalSetFavoritePermissionDenied)

local bool1 = game:DefineFastFlag("CloseFavoritePromptWithB", false)

local var1 = Roact.PureComponent:extend("SetFavoritePrompt")

var1.validateProps = t.strictInterface({
    itemId = t.integer,
    itemType = t.enum(Enum.AvatarItemType),
    itemName = t.string,
    shouldFavorite = t.boolean,
    screenSize = t.Vector2,
    performSetFavorite = t.callback,
    signalSetFavoritePermissionDenied = t.callback
})

function var1.init(arg1)
    function arg1.renderAlertMiddleContent()
        local var2 = nil
        if arg1.props.itemType == Enum.AvatarItemType.Asset then
            var2 = "Asset"
        elseif arg1.props.itemType == Enum.AvatarItemType.Bundle then
            var2 = "BundleThumbnail"
        end

        local image = "rbxthumb://type=" .. var2 .. "&id=" .. arg1.props.itemId .. "&w=150&h=150"

        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 150)
        }, {
            Thumnail = Roact.createElement(LoadableImage, {
                Position = UDim2.fromScale(0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0),
                Size = UDim2.fromOffset(150, 150),
                BackgroundTransparency = 1,
                Image = image,
                useShimmerAnimationWhileLoading = true,
                showFailedStateWhenLoadingFailed = true
            })
        })
    end

    if not bool1 then
        return
    end

    arg1.menuKey = "favorite_prompt_" .. arg1.props.itemId

    GuiService:SetMenuIsOpen(true, arg1.menuKey)
    ContextActionService:BindCoreAction(arg1.menuKey, function(_, userInputState, _)
        if userInputState ~= Enum.UserInputState.End then
            return Enum.ContextActionResult.Pass
        end
        arg1.props.signalSetFavoritePermissionDenied()
        return Enum.ContextActionResult.Sink
    end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)
end

function var1.willUnmount(arg1)
    if bool1 then
        GuiService:SetMenuIsOpen(false, arg1.menuKey)
        ContextActionService:UnbindCoreAction(arg1.menuKey)
    end
end

function var1.render(arg1)
    local var2, var3

    if arg1.props.shouldFavorite then
        var2 = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.FavouriteItemPromptTitle")
        var3 = RobloxTranslator:FormatByKey(
            "CoreScripts.AvatarEditorPrompts.FavouriteItemPromptText",
            {
                RBX_NAME = arg1.props.itemName
            }
        )
    else
        var2 = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.UnfavouriteItemPromptTitle")
        var3 = RobloxTranslator:FormatByKey(
            "CoreScripts.AvatarEditorPrompts.UnfavouriteItemPromptText",
            {
                RBX_NAME = arg1.props.itemName
            }
        )
    end
    return Roact.createElement(InteractiveAlert, {
        title = var2,
        bodyText = var3,
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalSetFavoritePermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.FavouriteItemPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.performSetFavorite,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.FavouriteItemPromptYes"),
                        isDelayedInput = true,
                        enableInputDelayed = true,
                        delayInputSeconds = 3
                    },
                    isDefaultChild = false
                }
            }
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = arg1.props.screenSize,
        middleContent = arg1.renderAlertMiddleContent,
        isMiddleContentFocusable = false
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        itemId = arg1.promptInfo.itemId,
        itemType = arg1.promptInfo.itemType,
        itemName = arg1.promptInfo.itemName,
        shouldFavorite = arg1.promptInfo.shouldFavorite,
        screenSize = arg1.screenSize
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        performSetFavorite = function()
            return arg1(PerformSetFavorite)
        end,
        signalSetFavoritePermissionDenied = function()
            return arg1(SignalSetFavoritePermissionDenied)
        end
    }
end)(var1)
