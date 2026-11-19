-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local HumanoidViewport = require(scriptParentParent.HumanoidViewport)
local ItemsList = require(scriptParentParent.ItemsList)

local SignalSaveAvatarPermissionDenied = require(scriptParentParentParent.Thunks.SignalSaveAvatarPermissionDenied)
local PerformSaveAvatar = require(scriptParentParentParent.Thunks.PerformSaveAvatar)

local GetConformedHumanoidDescription = require(scriptParentParentParent.GetConformedHumanoidDescription)

local var1 = Roact.PureComponent:extend("SaveAvatarPrompt")

var1.validateProps = t.strictInterface({
    gameName = t.string,
    screenSize = t.Vector2,
    humanoidDescription = t.instanceOf("HumanoidDescription"),
    rigType = t.enum(Enum.HumanoidRigType),
    performSaveAvatar = t.callback,
    signalSaveAvatarPermissionDenied = t.callback
})

function var1.init(arg1)
    arg1.mounted = false

    arg1:setState({ conformedHumanoidDescription = nil, getConformedDescriptionFailed = false, itemListScrollable = false })

    arg1.middleContentRef = Roact.createRef()
    local contentSize, updateContentSize = Roact.createBinding(UDim2.new(1, 0, 0, 200))
    arg1.contentSize = contentSize
    arg1.updateContentSize = updateContentSize

    function arg1.onAlertSizeChanged(arg2)
        local absoluteSize = arg2.AbsoluteSize

        if not arg1.middleContentRef:getValue() then
            return
        end

        local absoluteSizeY = arg1.middleContentRef:getValue().AbsoluteSize.Y
        local var4 = absoluteSize.Y - absoluteSizeY
        local var5 = arg1.props.screenSize.Y - 60 - var4

        local yOffset = arg1.middleContentRef:getValue().AbsoluteSize.X / 2 - 10 + 80

        if not (yOffset < var5) then
            yOffset = var5
        end

        if absoluteSizeY ~= yOffset then
            arg1.updateContentSize(UDim2.new(1, 0, 0, yOffset))
        end
    end

    function arg1.itemListScrollableUpdated(itemListScrollable, offset)
        if offset == arg1.contentSize:getValue().Y.Offset then
            arg1:setState({ itemListScrollable = itemListScrollable })
        end
    end

    function arg1.retryLoadDescription()
        arg1:setState({ getConformedDescriptionFailed = false })

        arg1:getConformedHumanoidDescription()
    end

    function arg1.renderAlertMiddleContent()
        local conformedHumanoidDescription = arg1.state.conformedHumanoidDescription
        local getConformedDescriptionFailed = arg1.state.getConformedDescriptionFailed

        return Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                Size = arg1.contentSize,
                [Roact.Ref] = arg1.middleContentRef
            },
            {
                ItemsListFrame = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(0.45, 1)
                }, {
                    ItemsList = Roact.createElement(ItemsList, {
                        humanoidDescription = conformedHumanoidDescription,
                        retryLoadDescription = arg1.retryLoadDescription,
                        loadingFailed = getConformedDescriptionFailed,
                        itemListScrollableUpdated = arg1.itemListScrollableUpdated
                    })
                }),
                HumanoidViewportFrame = Roact.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(0.55, 1),
                        Position = UDim2.fromScale(0.45, 0),
                        LayoutOrder = 2
                    },
                    {
                        UIPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5) }),
                        HumanoidViewport = Roact.createElement(HumanoidViewport, {
                            humanoidDescription = conformedHumanoidDescription,
                            loadingFailed = getConformedDescriptionFailed,
                            retryLoadDescription = arg1.retryLoadDescription,
                            rigType = arg1.props.rigType
                        })
                    }
                ),
                UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = arg1.contentMaxSize })
            }
        )
    end
end

function var1.render(arg1)
    return Roact.createElement(InteractiveAlert, {
        title = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.SaveAvatarPromptTitle"),
        bodyText = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.SaveAvatarPromptText", { RBX_NAME = arg1.props.gameName }),
        buttonStackInfo = {
            buttons = {
                {
                    props = {
                        onActivated = arg1.props.signalSaveAvatarPermissionDenied,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.SaveAvatarPromptNo")
                    },
                    isDefaultChild = true
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = arg1.props.performSaveAvatar,
                        text = RobloxTranslator:FormatByKey("CoreScripts.AvatarEditorPrompts.SaveAvatarPromptYes")
                    },
                    isDefaultChild = false
                }
            }
        },
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = arg1.props.screenSize,
        middleContent = arg1.renderAlertMiddleContent,
        onAbsoluteSizeChanged = arg1.onAlertSizeChanged,
        isMiddleContentFocusable = arg1.state.itemListScrollable
    })
end

function var1.getConformedHumanoidDescription(arg1, arg2)
    GetConformedHumanoidDescription(arg2, true):andThen(function(conformedHumanoidDescription)
        if not arg1.mounted then
            return
        end

        arg1:setState({ conformedHumanoidDescription = conformedHumanoidDescription })
    end, function(_)
        if not arg1.mounted then
            return
        end

        arg1:setState({ getConformedDescriptionFailed = true })
    end)
end

function var1.didMount(arg1)
    arg1.mounted = true

    arg1:getConformedHumanoidDescription(arg1.props.humanoidDescription)
end

function var1.didUpdate(arg1, arg2, _)
    if arg1.props.humanoidDescription == arg2.humanoidDescription then
        return
    end

    arg1:setState({ conformedHumanoidDescription = Roact.None, getConformedDescriptionFailed = false })

    arg1:getConformedHumanoidDescription(arg1.props.humanoidDescription)
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        gameName = arg1.gameName,
        screenSize = arg1.screenSize,
        humanoidDescription = arg1.promptInfo.humanoidDescription,
        rigType = arg1.promptInfo.rigType
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        signalSaveAvatarPermissionDenied = function()
            return arg1(SignalSaveAvatarPermissionDenied)
        end,
        performSaveAvatar = function()
            return arg1(PerformSaveAvatar)
        end
    }
end)(var1)
