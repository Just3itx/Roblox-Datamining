-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local InteractiveAlert = require(CorePackages.Packages.UIBlox).App.Dialog.Alert.InteractiveAlert

local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local HumanoidViewport = require(scriptParentParent.HumanoidViewport)

local GetConformedHumanoidDescription = require(scriptParentParentParent.GetConformedHumanoidDescription)

local var1 = Roact.PureComponent:extend("PromptWithAvatarViewport")

var1.validateProps = t.strictInterface({
    humanoidDescription = t.instanceOf("HumanoidDescription"),
    rigType = t.enum(Enum.HumanoidRigType),
    title = t.string,
    bodyText = t.optional(t.string),
    buttonStackInfo = t.table,
    screenSize = t.Vector2
})

function var1.init(arg1)
    arg1.mounted = false

    arg1.middleContentRef = Roact.createRef()
    local contentSize, updateContentSize = Roact.createBinding(UDim2.new(1, 0, 0, 200))
    arg1.contentSize = contentSize
    arg1.updateContentSize = updateContentSize

    arg1:setState({ conformedHumanoidDescription = nil, getConformedDescriptionFailed = false })

    function arg1.onAlertSizeChanged(arg2)
        local absoluteSize = arg2.AbsoluteSize

        if not arg1.middleContentRef:getValue() then
            return
        end

        local absoluteSizeY = arg1.middleContentRef:getValue().AbsoluteSize.Y
        local var4 = absoluteSize.Y - absoluteSizeY
        local var5 = arg1.props.screenSize.Y - 60 - var4

        local yOffset = arg1.middleContentRef:getValue().AbsoluteSize.X - 20

        if not (yOffset < var5) then
            yOffset = var5
        end

        if absoluteSizeY ~= yOffset then
            arg1.updateContentSize(UDim2.new(1, 0, 0, yOffset))
        end
    end

    function arg1.retryLoadDescription()
        arg1:setState({ getConformedDescriptionFailed = false })

        arg1:getConformedHumanoidDescription()
    end
end

function var1.renderAlertMiddleContent(arg1)
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
            HumanoidViewport = Roact.createElement(HumanoidViewport, {
                humanoidDescription = conformedHumanoidDescription,
                loadingFailed = getConformedDescriptionFailed,
                retryLoadDescription = arg1.retryLoadDescription,
                rigType = arg1.props.rigType
            })
        }
    )
end

function var1.render(arg1)
    return Roact.createElement(InteractiveAlert, {
        title = arg1.props.title,
        bodyText = arg1.props.bodyText,
        buttonStackInfo = arg1.props.buttonStackInfo,
        position = UDim2.fromScale(0.5, 0.5),
        screenSize = arg1.props.screenSize,
        middleContent = function()
            return arg1:renderAlertMiddleContent()
        end,
        onAbsoluteSizeChanged = arg1.onAlertSizeChanged,
        isMiddleContentFocusable = false
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
    if arg2.humanoidDescription == arg1.props.humanoidDescription then
        return
    end

    arg1:setState({ conformedHumanoidDescription = Roact.None, getConformedDescriptionFailed = false })

    arg1:getConformedHumanoidDescription(arg1.props.humanoidDescription)
end

function var1.willUnmount(arg1)
    arg1.mounted = false
end

return (RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        screenSize = arg1.screenSize
    }
end, nil)(var1))
