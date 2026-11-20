-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local FitFrame = require(scriptParentParentParentParentParent.FitFrame)
local Foundation = require(scriptParentParentParentParentParent.Foundation)
local FitFrameVertical = FitFrame.FitFrameVertical

local Label = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent).Label
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local ButtonType = require(scriptParentParentParentParent.App.Button.Enum.ButtonType)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)

local Checkbox = Foundation.Checkbox

local PartialPageModal = require(scriptParent.PartialPageModal)

local var1 = Roact.PureComponent:extend("EducationalModal")

var1.validateProps = t.strictInterface({
    bodyContents = t.array(
        t.strictInterface({
            icon = t.optional(t.union(t.string, t.table)),
            text = t.string,
            layoutOrder = t.optional(t.integer),
            isSystemMenuIcon = t.optional(t.boolean)
        })
    ),
    hasDoNotShow = t.optional(t.boolean),
    cancelText = t.string,
    confirmText = t.string,
    doNotShowText = t.optional(t.string),
    titleText = t.optional(t.string),
    titleBackgroundImageProps = t.strictInterface({ image = t.string, imageHeight = t.number, text = t.optional(t.string) }),
    screenSize = t.Vector2,
    onDismiss = t.callback,
    onCancel = t.callback,
    onConfirm = t.callback
})

local function ContentItem(arg1)
    local vector2 = Vector2.new(16, 16)

    local isSystemMenuIcon = arg1.isSystemMenuIcon or false
    local var2 = isSystemMenuIcon or arg1.icon

    local stylePalette = arg1.stylePalette
    local theme = stylePalette.Theme
    local font = stylePalette.Font
    local textSize = font.Body.RelativeSize * font.BaseSize

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = var2 and UDim2.new(0, 253, 0, vector2.Y) or UDim2.new(1, 0, 0, vector2.Y),
        AutomaticSize = var2 and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = arg1.layoutOrder
    }
    local tbl2 = {
        HorizontalLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = isSystemMenuIcon and UDim.new(0, 10) or UDim.new(0, 8),
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        Padding = Roact.createElement("UIPadding", { PaddingLeft = isSystemMenuIcon and UDim.new(0, 2) or UDim.new(0, 0) }),
        Icon = 0,
        Text = 0
    }
    local element = isSystemMenuIcon
        and Roact.createElement(Label, {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(32, 32),
            Image = "rbxasset://textures/ui/TopBar/iconBase.png",
            LayoutOrder = 1
        }, {
            Icon = Roact.createElement(Label, {
                ZIndex = 1,
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromOffset(24, 24),
                Image = "rbxasset://textures/ui/TopBar/coloredlogo.png"
            })
        })

    if not element then
        if var2 then
            element = Roact.createElement(Label, {
                Image = arg1.icon,
                Size = UDim2.fromOffset(getIconSize(IconSize.Medium), getIconSize(IconSize.Medium)),
                ImageColor3 = theme.IconDefault.Color,
                ImageTransparency = theme.IconDefault.Transparency,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
                or nil
        else
            element = nil
        end
    end

    tbl2.Icon = element

    tbl2.Text = arg1.text
        and Roact.createElement(GenericTextLabel, {
            Size = UDim2.new(1, 0, 0, vector2.Y),
            AutomaticSize = var2 and Enum.AutomaticSize.None or Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = arg1.text,
            TextSize = textSize,
            colorStyle = theme.TextDefault,
            TextTransparency = theme.TextDefault.Transparency,
            fontStyle = font.Body,
            TextXAlignment = var2 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
            TextWrapped = true,
            LayoutOrder = 2
        })
    return createElement(str1, tbl1, tbl2)
end

function var1.init(arg1)
    arg1.state = { shouldNotShowAgain = false }

    local contentSize, changeContentSize = Roact.createBinding(Vector2.new(0, 0))
    arg1.contentSize = contentSize
    arg1.changeContentSize = changeContentSize

    function arg1.toggleDoNotShow()
        arg1:setState(function(arg2)
            return {
                shouldNotShowAgain = not arg2.shouldNotShowAgain
            }
        end)
    end

    function arg1.onDismiss()
        arg1.props.onDismiss(arg1.state.shouldNotShowAgain)
    end
    function arg1.onCancel()
        arg1.props.onCancel(arg1.state.shouldNotShowAgain)
    end
    function arg1.onConfirm()
        arg1.props.onConfirm(arg1.state.shouldNotShowAgain)
    end
end

function var1.render(arg1)
    local props = arg1.props
    local hasDoNotShow = props.hasDoNotShow

    return withStyle(function(stylePalette)
        local num1 = 0
        local tbl1 = {}
        for layoutOrder, bodyContent in ipairs(props.bodyContents) do
            table.insert(
                tbl1,
                (Roact.createElement(ContentItem, {
                    key = tostring(layoutOrder),
                    icon = bodyContent.icon,
                    text = bodyContent.text,
                    layoutOrder = layoutOrder,
                    isSystemMenuIcon = bodyContent.isSystemMenuIcon,
                    stylePalette = stylePalette
                }))
            )
            num1 += 1
        end
        local theme = stylePalette.Theme

        if hasDoNotShow then
            table.insert(
                tbl1,
                (Roact.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 50),
                    LayoutOrder = num1 + 1,
                    BackgroundTransparency = 1
                }, {
                    UIListLayout = Roact.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical,
                        Padding = UDim.new(0, 21),
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }),
                    Divider = Roact.createElement("Frame", {
                        LayoutOrder = 1,
                        BackgroundColor3 = theme.Divider.Color,
                        BackgroundTransparency = theme.Divider.Transparency,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 1)
                    }),
                    DoNotShowCheckbox = Roact.createElement(Checkbox, {
                        label = props.doNotShowText,
                        onActivated = arg1.toggleDoNotShow,
                        isChecked = arg1.state.shouldNotShowAgain,
                        LayoutOrder = 2
                    })
                }))
            )
        end

        local createElement = Roact.createElement
        local var2 = PartialPageModal
        local tbl2 = {
            title = props.titleText,
            titleBackgroundImageProps = props.titleBackgroundImageProps,
            screenSize = props.screenSize,
            bottomPadding = 50,
            buttonStackProps = 0,
            onCloseClicked = 0
        }
        local buttonStackProps = {
            buttons = {
                {
                    props = {
                        isDisabled = false,
                        onActivated = if hasDoNotShow then arg1.onCancel else props.onCancel,
                        text = props.cancelText
                    }
                },
                {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        isDisabled = false,
                        onActivated = if hasDoNotShow then arg1.onConfirm else props.onConfirm,
                        text = props.confirmText
                    }
                }
            }
        }
        tbl2.buttonStackProps = buttonStackProps

        tbl2.onCloseClicked = if hasDoNotShow then arg1.onDismiss else props.onDismiss
        local tbl4 = { BodyContents = 0 }
        local createElement2 = Roact.createElement
        local var3 = FitFrameVertical
        local tbl5 = {
            BackgroundTransparency = 1,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            width = UDim.new(1, 0),
            contentPadding = UDim.new(0, 28),
            margin = { top = 36, bottom = 36 }
        }

        tbl5[Roact.Change.AbsoluteSize] = function(arg2)
            arg1.changeContentSize(arg2.AbsoluteSize)
        end

        tbl4.BodyContents = createElement2(var3, tbl5, tbl1)
        return createElement(var2, tbl2, tbl4)
    end)
end

return var1
