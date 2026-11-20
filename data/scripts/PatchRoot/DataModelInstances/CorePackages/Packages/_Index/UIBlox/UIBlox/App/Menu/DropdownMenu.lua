-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)

local Images = require(scriptParentParentParent.App.ImageSet.Images)
local ControlState = require(scriptParentParentParent.Core.Control.Enum.ControlState)

local DropdownMenuList = require(scriptParentParentParent.App.Menu.DropdownMenuList)
local DropdownMenuCell = require(scriptParentParentParent.App.Menu.DropdownMenuCell)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)

local bind = require(scriptParentParentParent.Utility.bind)
local useStyle = require(scriptParentParentParent.Core.Style.useStyle)
local StyleDefaults = require(script.Parent.StyleDefaults)

local function getCellDataKey(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if arg1.key == nil then arg1.text else arg1.key
end

local var1 = Roact.Component:extend("DropdownMenu")

var1.validateProps = t.strictInterface({
    placeholder = t.string,
    onChange = t.callback,
    height = t.optional(t.UDim),
    screenSize = t.Vector2,
    showDropShadow = t.optional(t.boolean),
    fixedListHeight = t.optional(t.number),
    errorState = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    onMenuOpenChange = t.optional(t.callback),
    menuListBackground = t.optional(validateColorInfo),
    cellDatas = t.array(
        t.strictInterface({
            icon = t.optional(t.union(t.table, t.string)),
            text = t.string,
            key = t.optional(t.string),
            disabled = t.optional(t.boolean),
            keyCodeLabel = t.optional(
                t.union(t.enum(Enum.KeyCode), t.strictInterface({ key = t.enum(Enum.KeyCode), axis = t.optional(t.string) }))
            ),
            iconColorOverride = t.optional(t.Color3),
            textColorOverride = t.optional(t.Color3)
        })
    ),
    menuStateColors = t.optional(
        t.strictInterface({
            buttonDefault = t.optional(validateColorInfo),
            contentDefault = t.optional(validateColorInfo),
            alert = t.optional(validateColorInfo)
        })
    ),
    enableTokenOverride = t.optional(t.boolean),
    isForcedClosed = t.optional(t.boolean),
    selectionOrder = t.optional(t.number),
    dropdownMenuListPositionFixed = t.optional(t.boolean),
    defaultKey = t.optional(t.string)
})

var1.defaultProps = {
    showDropShadow = false,
    fixedListHeight = nil,
    enableTokenOverride = false,
    dropdownMenuListPositionFixed = false,
    defaultKey = nil
}

function var1.didUpdate(arg1, _, arg2)
    if arg1.props.onMenuOpenChange and arg1.state.menuOpen ~= arg2.menuOpen then
        arg1.props.onMenuOpenChange(arg1.state.menuOpen)
    end
end

function var1.init(arg1)
    arg1:setState({ menuOpen = false, selectedKey = arg1.props.defaultKey, absoluteSize = Vector2.new(0, 0) })

    function arg1.openMenu()
        arg1:setState({ menuOpen = true })
    end

    function arg1.closeMenu()
        arg1:setState({ menuOpen = false })
    end

    function arg1.onSelect(selectedKey)
        arg1:setState({ menuOpen = false, selectedKey = selectedKey })

        arg1.props.onChange(selectedKey)
    end

    function arg1.mapCellData(arg2)
        local cellDataKey = getCellDataKey(arg2)
        local var2 = Cryo.Dictionary.join(arg2, { key = Cryo.None })

        var2.onActivated = bind(arg1.onSelect, cellDataKey)
        var2.selected = arg1.state.selectedKey == cellDataKey
        return var2
    end

    function arg1.onResize(arg2)
        arg1:setState({ absoluteSize = arg2.AbsoluteSize })
    end
end

function var1.getDerivedStateFromProps(arg1, arg2): {selectedKey: any}?
    local bool1 = false
    for _, cellData in arg1.cellDatas do
        if getCellDataKey(cellData) == arg2.selectedKey then
            bool1 = true
            break
        end
    end

    return if bool1 then nil else {
        selectedKey = Roact.None
    }
end

function var1.render(arg1)
    local cellDatas = arg1.props.cellDatas
    local buttonProps = Cryo.List.map(cellDatas, arg1.mapCellData)

    local selectionOrder = arg1.props.selectionOrder

    local where = Cryo.List.findWhere(buttonProps, function(arg2)
        return arg2.selected
    end)

    local text = if where ~= nil then buttonProps[where].text else arg1.props.placeholder
    local bool1 = arg1.state.absoluteSize.X > 640
    local tbl1, tbl2

    if arg1.props.enableTokenOverride then
        local buttonDefault = arg1.props.menuStateColors.buttonDefault
        local contentDefault = arg1.props.menuStateColors.contentDefault

        if arg1.props.errorState then
            buttonDefault = arg1.props.menuStateColors.alert
        end

        tbl1 = {
            [ControlState.Default] = buttonDefault
        }
        tbl2 = {
            [ControlState.Default] = contentDefault
        }
    else
        local str1 = "SecondaryDefault"

        local str2 = if arg1.state.menuOpen then str1 else "SecondaryOnHover"

        if arg1.props.errorState then
            str1 = "Alert"
            str2 = "Alert"
        end

        tbl1 = {
            [ControlState.Default] = str1,
            [ControlState.Hover] = str2
        }
        tbl2 = {
            [ControlState.Default] = "TextEmphasis"
        }
    end

    if arg1.props.isForcedClosed and arg1.state.menuOpen then
        arg1:setState({ menuOpen = false })
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = UDim2.new(UDim.new(1, 0), arg1.props.height),
        BackgroundTransparency = 1,
        [Roact.Change.AbsoluteSize] = arg1.onResize,
        [Roact.Ref] = arg1.props[Roact.Ref]
    }
    local tbl4 = { InnerFrame = 0 }
    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl5 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }
    local tbl6 = {
        SpawnButton = Roact.createElement(DropdownMenuCell, {
            Size = UDim2.fromScale(1, 1),
            buttonImage = Images["component_assets/circle_17_stroke_1"],
            buttonStateColorMap = tbl1,
            contentStateColorMap = tbl2,
            icon = arg1.state.menuOpen and Images["truncate_arrows/actions_truncationCollapse"]
                or Images["truncate_arrows/actions_truncationExpand"],
            text = text,
            isDisabled = arg1.props.isDisabled,
            isLoading = false,
            isActivated = arg1.state.menuOpen,
            hasContent = where ~= nil,
            userInteractionEnabled = true,
            onActivated = function()
                if arg1.state.menuOpen then
                    arg1.closeMenu()
                    return
                end
                arg1.openMenu()
            end,
            enableTokenOverride = arg1.props.enableTokenOverride,
            SelectionOrder = selectionOrder
        }),
        DropdownMenuList = Roact.createElement(DropdownMenuList, {
            buttonProps = buttonProps,
            zIndex = 2,
            open = arg1.state.menuOpen,
            openPositionY = UDim.new(0, 12),
            buttonSize = UDim2.fromScale(1, 1),
            closeBackgroundVisible = false,
            menuListBackground = arg1.props.menuListBackground,
            screenSize = arg1.props.screenSize,
            showDropShadow = arg1.props.showDropShadow,
            fixedListHeight = arg1.props.fixedListHeight,
            onDismiss = arg1.closeMenu,
            enableTokenOverride = arg1.props.enableTokenOverride,
            selectionOrder = if selectionOrder then selectionOrder + 1 else nil,
            menuPositionFixed = arg1.props.dropdownMenuListPositionFixed
        }),
        UISizeConstraint = bool1 and Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(300, math.huge) }) or nil
    }

    tbl4.InnerFrame = createElement2(str2, tbl5, tbl6) or nil
    return createElement(str1, tbl3, tbl4)
end

return Roact.forwardRef(function(arg1, arg2)
    if arg1.enableTokenOverride then
        local var2 = useStyle()
        local dropdownMenuDefaultTokens = StyleDefaults.getDropdownMenuDefaultTokens(var2)

        local menuStateColors = Cryo.Dictionary.join(dropdownMenuDefaultTokens.menuStateColors, arg1.menuStateColors or {})
        arg1 = Cryo.Dictionary.join(
            arg1,
            {
                height = arg1.height or dropdownMenuDefaultTokens.height,
                menuStateColors = menuStateColors
            }
        )
    end

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { [Roact.Ref] = arg2 }))
end)
