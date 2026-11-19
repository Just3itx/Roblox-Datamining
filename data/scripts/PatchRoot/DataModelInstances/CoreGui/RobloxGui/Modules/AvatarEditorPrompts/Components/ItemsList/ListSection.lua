-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Cryo = require(CorePackages.Packages.Cryo)
local Roact = require(CorePackages.Packages.Roact)
local RoactGamepad = require(CorePackages.Packages.RoactGamepad)
local t = require(CorePackages.Packages.t)
local RoactFitComponents = require(CorePackages.Packages.AvatarExperienceDeps).RoactFitComponents

local ListEntry = require(script.Parent.ListEntry)

local var1 = Roact.PureComponent:extend("ListSection")

var1.validateProps = t.strictInterface({
    headerText = t.string,
    items = t.array(t.string),
    layoutOrder = t.integer,
    isFirstSection = t.boolean,
    isLastSection = t.boolean,
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    forwardRef = t.table
})

function var1.init(arg1)
    arg1.listRefCache = RoactGamepad.createRefCache()
end

function var1.render(arg1)
    local tbl1 = ({})

    local num1 = 0
    tbl1[num1] = Roact.createElement(RoactGamepad.Focusable[ListEntry], {
        text = arg1.props.headerText,
        hasBullet = false,
        layoutOrder = 0,
        positionChangedCallback = if arg1.props.isFirstSection then arg1.firstEntryPositionChanged or nil else nil,
        NextSelectionDown = if #arg1.props.items > 0 then arg1.listRefCache[1] or nil else nil,
        [Roact.Ref] = arg1.listRefCache[0]
    })

    for layoutOrder, text in ipairs(arg1.props.items) do
        local lastEntryPositionChanged = if arg1.props.isLastSection and layoutOrder == #arg1.props.items then arg1.lastEntryPositionChanged else nil
        local createElement = Roact.createElement
        local var2 = RoactGamepad.Focusable[ListEntry]
        local tbl2 = {
            text = text,
            hasBullet = true,
            layoutOrder = layoutOrder,
            positionChangedCallback = lastEntryPositionChanged,
            NextSelectionUp = arg1.listRefCache[layoutOrder - 1],
            NextSelectionDown = if layoutOrder == #arg1.props.items then nil else arg1.listRefCache[layoutOrder + 1] or nil,
            [Roact.Ref] = arg1.listRefCache[layoutOrder]
        }
        tbl1[layoutOrder] = createElement(var2, tbl2)
    end

    local forwardRef = arg1.props.forwardRef

    return Roact.createElement(RoactGamepad.Focusable[RoactFitComponents.FitFrameVertical], {
        width = UDim.new(1, 0),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.layoutOrder,
        defaultChild = arg1.listRefCache[0],
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionUp = arg1.props.NextSelectionUp,
        NextSelectionDown = arg1.props.NextSelectionDown,
        [Roact.Ref] = forwardRef
    }, tbl1)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
