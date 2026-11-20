-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Otter = require(scriptParentParentParent.Otter)
local Roact = require(scriptParentParentParent.Roact)
local Cryo = require(scriptParentParentParent.Cryo)
local t = require(scriptParentParentParent.t)
local withStyle = require(scriptParentParentParent.UIBlox.Core.Style.withStyle)
local ModalBottomSheetButton = require(script.Parent.ModalBottomSheetButton)

local var1 = Roact.PureComponent:extend("ModalBottomSheet")

local tbl1 = { frequency = 4, dampingRatio = 1 }

var1.validateProps = t.strictInterface({
    buttonModels = t.array(t.table),
    screenWidth = t.number,
    onDismiss = t.callback,
    showImages = t.optional(t.boolean),
    bottomGap = t.optional(t.number),
    sheetContentXSize = t.optional(t.UDim),
    sheetContentXPosition = t.optional(t.UDim)
})

var1.defaultProps = {
    bottomGap = 0,
    showImages = true,
    sheetContentXSize = UDim.new(1, 0),
    sheetContentXPosition = UDim.new(0, 0)
}

function var1.init(arg1)
    arg1.motor = Otter.createSingleMotor(0)
    arg1.ref = Roact.createRef()
    arg1.active = true
end

function var1.render(arg1)
    local sheetContentXPosition = arg1.props.sheetContentXPosition
    local sheetContentXSize = arg1.props.sheetContentXSize

    arg1.sheetHeight = #arg1.props.buttonModels * 56
    if #arg1.props.buttonModels >= 7 then
        arg1.sheetHeight = 420
    end
    local tbl2 = {}
    for layoutOrder, buttonModel in ipairs(arg1.props.buttonModels) do
        local join = Cryo.Dictionary.join
        local tbl3 = {
            hasRoundTop = layoutOrder == 1,
            hasRoundBottom = layoutOrder == #arg1.props.buttonModels,
            isFixed = arg1.props.screenWidth > 600,
            elementHeight = 56,
            showImage = arg1.props.showImages,
            LayoutOrder = layoutOrder,
            onActivatedAndDismissed = 0
        }

        function tbl3.onActivatedAndDismissed(arg2)
            if buttonModel.onActivated then
                buttonModel.onActivated(arg2)
            end
            if not buttonModel.stayOnActivated then
                arg1.props.onDismiss()
            end
        end

        local var2 = join(buttonModel, tbl3)

        tbl2["button " .. layoutOrder] = Roact.createElement(ModalBottomSheetButton, var2)
    end

    tbl2.layout = Roact.createElement("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local tbl3 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl4 = { Background = 0, SheetContent = 0 }
        local createElement2 = Roact.createElement
        local tbl5 = {
            ZIndex = 0,
            AutoButtonColor = false,
            BackgroundColor3 = arg2.Theme.Overlay.Color,
            BackgroundTransparency = arg2.Theme.Overlay.Transparency,
            BorderSizePixel = 0,
            Selectable = false,
            Size = UDim2.new(1, 0, 1, 0),
            Text = ""
        }

        tbl5[Roact.Event.Activated] = function()
            arg1.active = false
            arg1.motor:setGoal(Otter.spring(0, tbl1))
        end

        tbl4.Background = createElement2("TextButton", tbl5)

        tbl4.SheetContent = Roact.createElement("ScrollingFrame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(sheetContentXSize.Scale, sheetContentXSize.Offset, 0, arg1.sheetHeight),
            Position = UDim2.new(sheetContentXPosition.Scale, sheetContentXPosition.Offset, 1, 0),
            Selectable = false,
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(sheetContentXSize.Scale, sheetContentXSize.Offset, 0, #arg1.props.buttonModels * 56),
            ClipsDescendants = true,
            [Roact.Ref] = arg1.ref
        }, tbl2)
        return createElement("Frame", tbl3, tbl4)
    end)
end

function var1.didMount(arg1)
    local sheetContentXPosition = arg1.props.sheetContentXPosition
    arg1.motor:onStep(function(arg2)
        if arg1.ref.current then
            arg1.ref.current.Position = UDim2.new(
                sheetContentXPosition.Scale,
                sheetContentXPosition.Offset,
                1,
                -(arg1.sheetHeight + arg1.props.bottomGap) * arg2
            )
        end
    end)
    arg1.motor:setGoal(Otter.spring(1, tbl1))
    arg1.motor:onComplete(function()
        if not arg1.active then
            arg1.props.onDismiss()
        end
    end)
    arg1.motor:start()
end

function var1.willUnmount(arg1)
    arg1.motor:destroy()
end

return var1
