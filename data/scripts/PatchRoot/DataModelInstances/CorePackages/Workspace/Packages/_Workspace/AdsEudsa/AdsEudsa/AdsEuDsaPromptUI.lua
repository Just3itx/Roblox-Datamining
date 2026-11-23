-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)
local UIBlox = require(scriptParentParent.UIBlox)
local Cryo = require(scriptParentParent.Cryo)

local CoreScriptsRootProvider = require(scriptParentParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local RobloxTranslator = require(scriptParentParent.RobloxTranslator)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local useStyle = UIBlox.Core.Style.useStyle

local title = RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.WhyThisAd")
local text = RobloxTranslator:FormatByKey("CoreScripts.Ads.Action.Close")

local var3 = Roact.Component:extend("InteractiveAlert")

function var3.init(arg1)
    arg1.state = {
        screenSize = Vector2.new(0, 0),
        animating = false
    }
end

function var3.renderWithStyle(arg1, _)
    local tbl1 = {
        buttonType = ButtonType.PrimarySystem,
        props = {
            onActivated = function()
                arg1.props.handler:hidePrompt()
            end,
            text = text
        },
        isDefaultChild = true
    }

    local createFragment = Roact.createFragment
    local tbl2 = { Frame = 0 }
    local createElement = Roact.createElement
    local tbl3 = {
        Selectable = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }

    tbl3[Roact.Change.AbsoluteSize] = function(arg2)
        arg1:setState({ screenSize = arg2.AbsoluteSize })
    end

    tbl2.Frame = createElement("Frame", tbl3, {
        InteractiveAlert = Roact.createElement(InteractiveAlert, {
            screenSize = arg1.state.screenSize,
            title = title,
            bodyText = arg1.props.bodyText,
            buttonStackInfo = {
                buttons = { tbl1 }
            }
        })
    })
    return createFragment(tbl2)
end

function var3.render(arg1)
    return arg1:renderWithStyle(arg1.props.style)
end

return function(arg1)
    local style = useStyle()

    local var5 = Cryo.Dictionary.join(arg1, { style = style })

    return Roact.createElement(CoreScriptsRootProvider, {}, {
        FocusNavigationCoreScriptsWrapper = Roact.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            {
                WrappedEuDsaPrompt = Roact.createElement(var3, var5)
            }
        )
    })
end
