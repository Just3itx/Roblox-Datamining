-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact

local CloseMenuButton = require(script.Parent.CloseMenuButton)
local GameIconButton = require(script.Parent.GameIconButton)

local var1 = Roact.PureComponent:extend("SystemMenuButton")

var1.validateProps = t.strictInterface({
    on = t.optional(t.boolean),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    onActivated = t.callback,
    onClose = t.callback,
    canCaptureFocus = t.optional(t.boolean)
})

var1.defaultProps = { on = false, canCaptureFocus = false }

function var1.tryCaptureFocus(arg1, arg2)
    if arg1.props.canCaptureFocus and not arg2.canCaptureFocus
        or arg1.props.canCaptureFocus and arg1.props.on ~= arg2.on and arg1.state.isIconFocused
    then
        GuiService.SelectedCoreObject = arg1.iconRef:getValue()
    end
end

function var1.init(arg1)
    arg1.iconRef = Roact.createRef()

    arg1:setState({ isIconFocused = false })

    function arg1.onIconSelectionGained()
        arg1:setState({ isIconFocused = true })
    end

    function arg1.onIconSelectionLost()
        arg1:setState({ isIconFocused = false })
    end
end

function var1.didMount(arg1)
    arg1:tryCaptureFocus({ canCaptureFocus = false })
end

function var1.didUpdate(arg1, arg2)
    arg1:tryCaptureFocus(arg2)
end

function var1.render(arg1)
    if arg1.props.on then
        return Roact.createElement(CloseMenuButton, {
            onActivated = arg1.props.onClose,
            layoutOrder = arg1.props.layoutOrder,
            AnchorPoint = arg1.props.anchorPoint,
            Position = arg1.props.position,
            onSelectionGained = arg1.onIconSelectionGained,
            onSelectionLost = arg1.onIconSelectionLost,
            [Roact.Ref] = arg1.iconRef
        })
    end
    return Roact.createElement(GameIconButton, {
        onActivated = arg1.props.onActivated,
        layoutOrder = arg1.props.layoutOrder,
        anchorPoint = arg1.props.anchorPoint,
        position = arg1.props.position,
        onSelectionGained = arg1.onIconSelectionGained,
        onSelectionLost = arg1.onIconSelectionLost,
        [Roact.Ref] = arg1.iconRef
    })
end

return var1
