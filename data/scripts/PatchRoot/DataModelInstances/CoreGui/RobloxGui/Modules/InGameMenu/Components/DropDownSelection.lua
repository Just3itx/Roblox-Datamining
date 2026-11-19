-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local Assets = require(scriptParentParent.Resources.Assets)
local divideTransparency = require(scriptParentParent.Utility.divideTransparency)

local ThemedButton = require(script.Parent.ThemedButton)
local ThemedTextLabel = require(script.Parent.ThemedTextLabel)
local Divider = require(script.Parent.Divider)
local BarOnTopScrollingFrame = require(script.Parent.BarOnTopScrollingFrame)
local FocusHandler = require(script.Parent.Connection.FocusHandler)

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local var1 = Roact.PureComponent:extend("DropDownSelection")

var1.validateProps = t.intersection(
    t.strictInterface({
        Size = t.UDim2,
        Position = t.optional(t.UDim2),
        LayoutOrder = t.optional(t.integer),
        placeHolderText = t.optional(t.string),
        selectedIndex = t.numberMin(0),
        selections = t.array(t.string),
        localize = t.boolean,
        enabled = t.boolean,
        truncate = t.optional(t.boolean),
        selectionChanged = t.callback,
        canOpen = t.optional(t.boolean),
        canCaptureFocus = t.optional(t.boolean),
        selectionParentName = t.optional(t.string),
        ButtonRef = t.optional(t.table)
    }),
    function(arg1)
        if arg1.selectedIndex > #arg1.selections then
            return false, "selectedIndex must not be greater than the number of selections"
        end

        return true
    end
)

var1.defaultProps = { canOpen = true }

function var1.init(arg1)
    arg1.rootRef = Roact.createRef()
    arg1.firstOptionRef = Roact.createRef()
    arg1.openDropDownButtonRef = arg1.props.ButtonRef or Roact.createRef()

    arg1.state = {
        isOpen = false,
        dropDownItemHeight = 10,
        absolutePositionX = 0,
        absolutePositionY = 0,
        screenSizeX = 0,
        screenSizeY = 0
    }

    arg1.ancestryConnection = nil
    arg1.sizeConnection = nil
end

function var1.getDerivedStateFromProps(arg1): {isOpen: boolean}?
    return if arg1.canOpen then nil else { isOpen = false }
end

function var1.renderDropDownList(arg1, arg2, arg3)
    local tbl1 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    }
    for i, selection in ipairs(arg1.props.selections) do
        local var2 = selection
        if arg1.props.localize then
            var2 = arg3[i]
        end

        local xOffset = if arg1.props.truncate and i == 1 then -48 else -25

        local var3 = "button" .. i
        local createElement = Roact.createElement
        local var4 = ThemedButton
        local tbl2 = {
            Size = UDim2.new(1, 0, 0, arg1.state.dropDownItemHeight - 1),
            LayoutOrder = i * 2,
            onActivated = 0,
            normalThemeKey = "BackgroundUIDefault",
            hoverThemeKey = "BackgroundOnHover",
            ButtonRef = 0,
            imageProps = 0,
            renderChildren = 0
        }

        function tbl2.onActivated()
            arg1:setState({ isOpen = false })

            arg1.props.selectionChanged(i)
        end

        tbl2.ButtonRef = if i == 1 then arg1.firstOptionRef or nil else nil
        tbl2.imageProps = Assets.Images.WhiteSquare

        function tbl2.renderChildren(_, arg4, arg5)
            local var5 = arg4 and arg2.Theme.IconOnHover or arg2.Theme.IconDefault
            local color = var5.Color
            local imageTransparency = divideTransparency(var5.Transparency, if arg5 then 2 else 1)

            local tbl3 = {
                SelectedIcon = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Size = UDim2.new(0, 15, 0, 12),
                    Position = UDim2.new(1, -25, 0.5, 0),
                    Image = Assets.Images.SelectedCheck,
                    ImageColor3 = color,
                    ImageTransparency = imageTransparency,
                    Visible = arg1.props.selectedIndex == i
                }),
                TextLabel = Roact.createElement(ThemedTextLabel, {
                    fontKey = "Header2",
                    themeKey = "TextEmphasis",
                    Position = UDim2.new(0, 25, 0, 0),
                    Size = UDim2.new(1, xOffset, 1, 0),
                    Text = var2,
                    TextTruncate = if arg1.props.truncate then Enum.TextTruncate.AtEnd else Enum.TextTruncate.None,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            }
            return tbl3
        end

        tbl1[var3] = createElement(var4, tbl2)

        if i < #arg1.props.selections then
            local var5 = "divider" .. i
            tbl1[var5] = Roact.createElement(Divider, { LayoutOrder = i * 2 + 1 })
        end
    end

    return tbl1
end

function var1.renderFocusHandler(arg1)
    return if arg1.props.selectionParentName then Roact.createElement(FocusHandler, {
        isFocused = arg1.props.canOpen and arg1.state.isOpen,
        didFocus = function()
            ContextActionService:BindCoreAction("settings_dropdown_close_action", function(_, userInputState)
                if userInputState ~= Enum.UserInputState.End then
                    return Enum.ContextActionResult.Pass
                end

                arg1:setState({ isOpen = false })
                return Enum.ContextActionResult.Sink
            end, false, Enum.KeyCode.ButtonB)

            if arg1.props.canCaptureFocus then
                GuiService:RemoveSelectionGroup(arg1.props.selectionParentName)
                GuiService:AddSelectionParent(arg1.props.selectionParentName, arg1.rootRef.current)
                GuiService.SelectedCoreObject = arg1.firstOptionRef.current
            end
        end,
        didBlur = function()
            ContextActionService:UnbindCoreAction("settings_dropdown_close_action")
            GuiService:RemoveSelectionGroup(arg1.props.selectionParentName)

            if arg1.props.canOpen and not arg1.state.isOpen and arg1.props.canCaptureFocus then
                GuiService.SelectedCoreObject = arg1.openDropDownButtonRef.current
            end
        end
    })
        or nil else nil
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                BackgroundUIDefault = {
                    Color = arg2.Color.Surface.Surface_300.Color3,
                    Transparency = arg2.Color.Surface.Surface_300.Transparency
                },
                IconDefault = {
                    Color = arg2.Color.Content.Default.Color3,
                    Transparency = arg2.Color.Content.Default.Transparency
                },
                IconOnHover = {
                    Color = arg2.Color.Content.Emphasis.Color3,
                    Transparency = arg2.Color.Content.Emphasis.Transparency
                }
            }
        }
    end, function(arg2)
        return withLocalization(arg1.props.localize and arg1.props.selections or {})(function(arg3)
            local placeHolderText = arg1.props.placeHolderText
            if arg1.props.selectedIndex > 0 then
                if arg1.props.localize then
                    placeHolderText = arg3[arg1.props.selectedIndex]
                else
                    placeHolderText = arg1.props.selections[arg1.props.selectedIndex]
                end
            end

            local shadowSize = Assets.Images.Shadow.Size
            local num1 = math.min(#arg1.props.selections, 7.5) * 44
            local var2 = arg1:renderDropDownList(arg2, arg3)

            local createElement = Roact.createElement
            local tbl1 = {
                Size = arg1.props.Size,
                Position = arg1.props.Position,
                LayoutOrder = arg1.props.LayoutOrder,
                BackgroundTransparency = 1,
                [Roact.Ref] = arg1.rootRef
            }
            tbl1[Roact.Change.AbsoluteSize] = function(arg4)
                arg1:setState({ dropDownItemHeight = arg4.AbsoluteSize.Y })
            end

            tbl1[Roact.Change.AbsolutePosition] = function(arg4)
                arg1:setState({ absolutePositionX = arg4.AbsolutePosition.X, absolutePositionY = arg4.AbsolutePosition.Y })
            end

            local tbl2 = {
                OpenDropDownButton = Roact.createElement(ThemedButton, {
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = not arg1.state.isOpen,
                    enabled = arg1.props.enabled,
                    onActivated = function()
                        arg1:setState({ isOpen = true })
                    end,
                    normalThemeKey = "SecondaryDefault",
                    hoverThemeKey = "SecondaryOnHover",
                    imageProps = Assets.Images.RoundedRectBorder,
                    renderChildren = function(textTransparency, arg4, arg5)
                        local var3 = arg4 and arg2.Theme.IconOnHover or arg2.Theme.IconDefault
                        local color = var3.Color
                        local imageTransparency = divideTransparency(var3.Transparency, if arg5 then 2 else 1)

                        local tbl2 = {
                            ButtonIcon = Roact.createElement(ImageSetLabel, {
                                BackgroundTransparency = 1,
                                Size = UDim2.new(0, 36, 0, 36),
                                Position = UDim2.new(1, -16, 0.5, 0),
                                AnchorPoint = Vector2.new(1, 0.5),
                                Image = Assets.Images.ExpandArrow,
                                ImageColor3 = color,
                                ImageTransparency = imageTransparency
                            }),
                            ButtonText = Roact.createElement(ThemedTextLabel, {
                                Text = placeHolderText,
                                themeKey = "SecondaryContent",
                                fontKey = "Header2",
                                Position = UDim2.new(0, 12, 0, 0),
                                Size = UDim2.new(1, if arg1.props.truncate then -48 else -12, 1, 0),
                                TextTransparency = textTransparency,
                                TextTruncate = if arg1.props.truncate then Enum.TextTruncate.AtEnd else Enum.TextTruncate.None,
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                        }
                        return tbl2
                    end,
                    ButtonRef = arg1.openDropDownButtonRef
                }),
                CloseDropDownArea = 0,
                DropDownShadow = 0
            }

            local createElement2 = Roact.createElement
            local tbl3 = {
                BackgroundTransparency = 1,
                Text = "",
                Position = UDim2.new(0, -arg1.state.absolutePositionX, 0, -arg1.state.absolutePositionY),
                Size = UDim2.new(0, arg1.state.screenSizeX, 0, arg1.state.screenSizeY),
                Visible = arg1.state.isOpen,
                Selectable = false
            }

            tbl3[Roact.Event.Activated] = function()
                arg1:setState({ isOpen = false })
            end

            tbl3.ZIndex = 2
            tbl2.CloseDropDownArea = createElement2("TextButton", tbl3)

            tbl2.DropDownShadow = Roact.createElement(ImageSetLabel, {
                BackgroundTransparency = 1,
                Image = Assets.Images.Shadow.Image,
                Position = UDim2.new(0, -shadowSize, 0, -shadowSize),
                Size = UDim2.new(1, shadowSize * 2, 0, shadowSize * 2 + 8 + num1),
                ScaleType = Assets.Images.Shadow.ScaleType,
                SliceCenter = Assets.Images.Shadow.SliceCenter,
                Visible = arg1.state.isOpen,
                ZIndex = 3
            }, {
                FocusHandler = arg1:renderFocusHandler(),
                DropDownBackground = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Image = Assets.Images.RoundedRect.Image,
                    ImageColor3 = arg2.Theme.BackgroundUIDefault.Color,
                    ImageTransparency = arg2.Theme.BackgroundUIDefault.Transparency,
                    ScaleType = Assets.Images.RoundedRect.ScaleType,
                    Size = UDim2.new(1, -(shadowSize * 2), 1, -(shadowSize * 2)),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    SliceCenter = Assets.Images.RoundedRect.SliceCenter,
                    SliceScale = 0.5
                }, {
                    DropDownList = Roact.createElement(BarOnTopScrollingFrame, {
                        Position = UDim2.new(0, 0, 0, 4),
                        Size = UDim2.new(1, 0, 1, -8),
                        CanvasSize = UDim2.new(1, 0, 0, #arg1.props.selections * arg1.state.dropDownItemHeight)
                    }, var2)
                })
            })
            return createElement("Frame", tbl1, tbl2)
        end)
    end)
end

function var1.watchLayerCollector(arg1, arg2)
    arg1:setState({ screenSizeX = arg2.AbsoluteSize.X, screenSizeY = arg2.AbsoluteSize.Y })

    arg1.sizeConnection = arg2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        arg1:setState({ screenSizeX = arg2.AbsoluteSize.X, screenSizeY = arg2.AbsoluteSize.Y })
    end)
end

function var1.didMount(arg1)
    local current = arg1.rootRef.current
    local layerCollector = current:FindFirstAncestorWhichIsA("LayerCollector")

    if layerCollector ~= nil then
        arg1:watchLayerCollector(layerCollector)
        return
    end

    arg1.ancestryConnection = current.AncestryChanged:Connect(function()
        layerCollector = current:FindFirstAncestorWhichIsA("LayerCollector")
        if layerCollector ~= nil then
            arg1.ancestryConnection:Disconnect()
            arg1.ancestryConnection = nil
            arg1:watchLayerCollector(layerCollector)
        end
    end)
end

function var1.didUpdate(arg1, arg2)
    if arg2.ButtonRef ~= arg1.props.ButtonRef then
        arg1.openDropDownButtonRef = arg1.props.ButtonRef or Roact.createRef()
    end

    if arg1.state.isOpen and arg2.canCaptureFocus ~= arg1.props.canCaptureFocus then
        arg1:setState({ isOpen = false })
    end
end

function var1.willUnmount(arg1)
    if arg1.ancestryConnection then
        arg1.ancestryConnection:Disconnect()
    end
    if arg1.sizeConnection then
        arg1.sizeConnection:Disconnect()
    end
end

return var1
