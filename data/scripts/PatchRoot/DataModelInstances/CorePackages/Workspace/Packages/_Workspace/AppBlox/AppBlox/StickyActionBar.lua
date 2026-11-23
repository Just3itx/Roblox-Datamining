-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local UIBlox = require(AppBloxParent.UIBlox)

local t = require(AppBloxParent.t)
local Roact = require(AppBloxParent.Roact)
local GetTextSize = require(AppBloxParent.Style).GetTextSize
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local validateImage = UIBlox.Core.ImageSet.Validator.validateImage
local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local getIconSize = UIBlox.App.ImageSet.getIconSize
local withStyle = UIBlox.Core.Style.withStyle

local ActionBar = UIBlox.App.Button.ActionBar

local FFlagUIBloxEnableActionBarButtonOverride = require(AppBloxParent.SharedFlags).UIBlox.FFlagUIBloxEnableActionBarButtonOverride
local var1 = game:DefineFastFlag("LuaAppFixUnifiedPlayButtonStickyActionBar", false) and FFlagUIBloxEnableActionBarButtonOverride

local iconSize = getIconSize(IconSize.Large)

local var2 = Roact.PureComponent:extend("StickyActionBar")

var2.validateProps = t.strictInterface({
    actionBarProps = t.optional(t.table),
    actionBarWidth = t.optional(t.number),
    infoProps = t.optional(
        t.strictInterface({
            title = t.string,
            icon = t.optional(validateImage),
            enableInfoAtStart = t.optional(t.boolean),
            infoSectionWidth = t.optional(t.integer)
        })
    ),
    width = t.optional(t.integer),
    layoutOrder = t.optional(t.integer)
})

var2.defaultProps = {
    actionBarProps = nil,
    actionBarWidth = 380,
    infoProps = nil,
    layoutOrder = 1,
    width = nil
}

function var2.init(arg1)
    arg1.state = { containerWidth = nil }

    function arg1.onContainerSizeChange(arg2)
        arg1:setState(function(_, _)
            return {
                containerWidth = arg2.AbsoluteSize.X
            }
        end)
    end

    local function func1(): UDim2 -- Luacid: Inlined by compiler; 4 call sites recovered
        return UDim2.fromOffset(arg1.props.actionBarWidth, 48)
    end

    local function func2(num1: number, arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
        if arg3 and arg3.infoSectionWidth then
            return arg3.infoSectionWidth
        end

        local offset = func1().X.Offset

        return arg2 and num1 - 80 - offset or num1 - 80
    end

    local function func3(num1: number, arg2, arg3, bool1: boolean)
        if bool1 or not arg3 then
            return {
                horizontalAlignment = Enum.HorizontalAlignment.Left,
                left = 24,
                right = 24
            }
        end

        local var3 = (num1 - arg2) / 2

        local num2 = if num1 < 1280 then 24 else 80
        local offset = func1().X.Offset
        return {
            left = math.max(offset + num2, var3) - offset,
            right = 24
        }
    end

    local function _(arg2, arg3, arg4) -- Luacid: unused: defined but never referenced
        local baseSize = arg4.Font.BaseSize
        local var3 = arg3.RelativeSize * baseSize
        local vector2 = Vector2.new(10000, 10000)
        return GetTextSize(arg2, var3, arg3.Font, vector2).X
    end

    function arg1.getLayoutConfig(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
        local bool1 = if arg1.props.infoProps then not not arg1.props.infoProps.enableInfoAtStart else false
        local baseSize = arg8.Font.BaseSize
        local var3 = arg7.RelativeSize * baseSize
        local vector2 = Vector2.new(10000, 10000)
        local var4 = GetTextSize(arg6, var3, arg7.Font, vector2).X + arg5 + (if arg5 > 0 then 12 else 0)
        return {
            layoutOrder = bool1 and ({ infoSection = 1, actionBarSection = 2 } or {
                infoSection = 2,
                actionBarSection = 1
            })
                or { infoSection = 2, actionBarSection = 1 },
            infoHorizontalAlignment = Enum.HorizontalAlignment.Left,
            infoSectionWidth = func2(arg2, arg3, arg4),
            infoSectionPadding = func3(arg2, var4, arg3, bool1),
            actionBarSectionSize = func1(),
            actionBarSectionMarginOverride = { left = 0, right = 0, top = 0, bottom = 0 }
        }
    end
end

function var2.render(arg1)
    local bool1 = arg1.props.actionBarProps ~= nil
    local bool2 = arg1.props.infoProps ~= nil
    local var3 = arg1.props.width or arg1.state.containerWidth
    assert(bool1 or bool2, "Either actionbar or info should be present!")
    return withStyle(function(arg2)
        local var4 = bool2 and arg1.props.infoProps.icon and iconSize or 0
        local title = bool2 and arg1.props.infoProps.title or ""
        local header2 = arg2.Font.Header2
        local layoutConfig = arg1.getLayoutConfig(var3 or 0, bool1, arg1.props.infoProps, var4, title, header2, arg2)

        local var5 = arg1
        local tbl1 = {
            layoutOrder = arg1.props.layoutOrder,
            size = arg1.props.width and UDim2.new(0, arg1.props.width, 1, 0) or UDim2.fromScale(1, 1),
            onContainerSizeChange = arg1.onContainerSizeChange,
            horizontalAlignment = Enum.HorizontalAlignment.Left,
            padding = { left = 56, right = 24 }
        }

        local tbl2 = { ActionBarSection = 0, InfoSection = 0 }
        local var6

        if bool1 then
            local var7 = arg1
            local tbl3 = {
                layoutOrder = layoutConfig.layoutOrder.actionBarSection,
                size = layoutConfig.actionBarSectionSize,
                horizontalAlignment = Enum.HorizontalAlignment.Left
            }
            local tbl4 = {
                ActionBar = Roact.createElement(ActionBar, {
                    button = arg1.props.actionBarProps.button,
                    buttonOverride = if var1 then arg1.props.actionBarProps.buttonOverride else nil,
                    icons = arg1.props.actionBarProps.icons,
                    marginOverride = layoutConfig.actionBarSectionMarginOverride,
                    enableButtonAtStart = true
                })
            }
            var6 = var7:renderHorizontalLayout(tbl3, tbl4) or nil
        else
            var6 = nil
        end

        tbl2.ActionBarSection = var6

        local bool3 = bool2

        if bool3 then
            if var3 == nil then
                bool3 = false
            else
                bool3 = arg1:renderHorizontalLayout({
                    layoutOrder = layoutConfig.layoutOrder.infoSection,
                    width = layoutConfig.infoSectionWidth,
                    horizontalAlignment = layoutConfig.infoHorizontalAlignment,
                    padding = layoutConfig.infoSectionPadding,
                    internalSpacing = 12
                }, {
                    Icon = arg1.props.infoProps.icon
                        and Roact.createElement(
                            ImageSetLabel,
                            {
                                Size = UDim2.new(0, var4, 0, var4),
                                LayoutOrder = 1,
                                Position = UDim2.new(0, 0, 0, 0),
                                Image = arg1.props.infoProps.icon,
                                BackgroundTransparency = 1,
                                ScaleType = Enum.ScaleType.Crop
                            },
                            {
                                RoundCorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
                            }
                        )
                        or nil,
                    Title = Roact.createElement(StyledTextLabel, {
                        layoutOrder = 2,
                        size = UDim2.new(0, 0, 0, 48),
                        automaticSize = Enum.AutomaticSize.X,
                        text = title,
                        fluidSizing = false,
                        textWrapped = true,
                        textXAlignment = Enum.TextXAlignment.Left,
                        colorStyle = arg2.Theme.TextEmphasis,
                        fontStyle = header2,
                        textTruncate = Enum.TextTruncate.AtEnd
                    })
                })
            end
        end

        tbl2.InfoSection = bool3
        return var5:renderHorizontalLayout(tbl1, tbl2)
    end)
end

function var2.renderHorizontalLayout(_, arg1, arg2)
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = arg1.size and arg1.size or UDim2.new(0, arg1.width, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder,
        [Roact.Change.AbsoluteSize] = arg1.onContainerSizeChange
    }
    local tbl2 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = arg1.horizontalAlignment,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, arg1.internalSpacing or 0)
        }),
        Padding = 0,
        Elements = 0
    }
    local element

    if arg1.padding then
        element = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, arg1.padding.left or 0),
            PaddingRight = UDim.new(0, arg1.padding.right or 0),
            PaddingTop = UDim.new(0, arg1.padding.top or 0),
            PaddingBottom = UDim.new(0, arg1.padding.bottom or 0)
        })
    else
        element = nil
    end

    tbl2.Padding = element

    tbl2.Elements = Roact.createFragment(arg2)
    return createElement(str1, tbl1, tbl2)
end

return var2
