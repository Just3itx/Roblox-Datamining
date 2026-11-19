-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Foundation = require(CorePackages.Packages.Foundation)

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local FFlagResponsiveUnitsDeprecateTenFoot = require(CorePackages.Workspace.Packages.SharedFlags).FFlagResponsiveUnitsDeprecateTenFoot
local ExternalEventConnection = require(CorePackages.Workspace.Packages.RoactUtils).ExternalEventConnection

local Utility = require(RobloxGui.Modules.Settings.Utility)
local FrontButtonController = require(RobloxGui.Modules.Settings.FrontButtonController)

local var1 = Roact.PureComponent:extend("MenuFrontButton")
local var2 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot
local Theme = require(RobloxGui.Modules.Settings.Theme)

local bool1 = game:DefineFastFlag("ShowTeleportHistoryFrontButton", false)

var1.validateProps = t.strictInterface({
    HubBar = t.instanceOf("ImageLabel"),
    frontEnabled = t.boolean,
    FrontBarRef = t.optional(t.table),
    LayoutOrder = t.optional(t.integer)
})
var1.defaultProps = {
    frontEnabled = bool1 and FrontButtonController.hasReturnUniverse()
}
function var1.init(arg1)
    arg1:setState({ text = FrontButtonController.getMenuText() })

    local sizeBinding, updateSizeBinding = Roact.createBinding(nil)
    arg1.sizeBinding = sizeBinding
    arg1.updateSizeBinding = updateSizeBinding
    local sizeConstraintBinding, updateSizeConstraintBinding = Roact.createBinding(nil)
    arg1.sizeConstraintBinding = sizeConstraintBinding
    arg1.updateSizeConstraintBinding = updateSizeConstraintBinding
    local visibleBinding, updateVisibleBinding = Roact.createBinding(nil)
    arg1.visibleBinding = visibleBinding
    arg1.updateVisibleBinding = updateVisibleBinding
    local buttonHeightBinding, updateButtonHeightBinding = Roact.createBinding(nil)
    arg1.buttonHeightBinding = buttonHeightBinding
    arg1.updateButtonHeightBinding = updateButtonHeightBinding
    local textSizeBinding, updateTextSizeBinding = Roact.createBinding(nil)
    arg1.textSizeBinding = textSizeBinding
    arg1.updateTextSizeBinding = updateTextSizeBinding
    local textSizeConstraintBinding, updateTextSizeConstraintBinding = Roact.createBinding(nil)
    arg1.textSizeConstraintBinding = textSizeConstraintBinding
    arg1.updateTextSizeConstraintBinding = updateTextSizeConstraintBinding
    arg1.textLabelRef = Roact.createRef()
end

function var1.didMount(arg1)
    arg1.updateSizeBinding(arg1.props.HubBar.Size)
    arg1.updateVisibleBinding(arg1.props.HubBar.Visible)
    arg1:updateViewport()
end

function var1.didUpdate(arg1, arg2)
    if arg1.props.HubBar ~= arg2.HubBar then
        arg1.updateSizeBinding(arg1.props.HubBar.Size)
        arg1.updateVisibleBinding(arg1.props.HubBar.Visible)
    end
end

function var1.updateViewport(arg1)
    local var3 = Theme.textSize(24)
    if Utility:IsSmallTouchScreen() then
        var3 = Theme.textSize(18)
    elseif var2 then
        var3 = Theme.textSize(36)
    end
    arg1.updateTextSizeConstraintBinding(var3)
    local isPortrait = Utility:IsPortrait()
    local var4 = if var2 then 120 else Theme.LargeButtonHeight
    if isPortrait or Utility:IsSmallTouchScreen() then
        var4 = Theme.ButtonHeight
        var3 = isPortrait and Theme.textSize(16) or Theme.textSize(24)
    end
    arg1.updateTextSizeBinding(var3)
    arg1.updateButtonHeightBinding(var4)
    if arg1.textLabelRef:getValue() and arg1.props.FrontBarRef:getValue() then
        local var5 = arg1.textLabelRef:getValue().AbsolutePosition.X - arg1.props.FrontBarRef:getValue().AbsolutePosition.X
        arg1.updateSizeConstraintBinding(Vector2.new(arg1.props.FrontBarRef:getValue().AbsoluteSize.X - var5, math.huge))
    end
end

function var1.render(arg1)
    local createElement = Roact.createElement
    local str1 = "Frame"

    local tbl1 = {
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        LayoutOrder = arg1.props.LayoutOrder,
        Visible = Roact.joinBindings({ arg1.state.text, arg1.visibleBinding }):map(function(arg2)
            local frontEnabled = arg1.props.frontEnabled
            return frontEnabled and arg2[1] ~= nil and arg2[2]
        end),
        Size = Roact.joinBindings({ arg1.sizeBinding, arg1.buttonHeightBinding }):map(function(arg2): UDim2
            local var3 = arg2[1]
            local var4 = arg2[2]
            if var3 and var4 then
                return UDim2.new(UDim.new(var3.X.Scale * 0.5, var3.X.Offset * 0.5), UDim.new(0, var4 + 6))
            end

            return UDim2.new()
        end),
        [Roact.Ref] = arg1.props.FrontBarRef
    }

    local tbl2 = {
        SizeConnection = Roact.createElement(ExternalEventConnection, {
            event = arg1.props.HubBar:GetPropertyChangedSignal("Size"),
            callback = function()
                arg1.updateSizeBinding(arg1.props.HubBar.Size)
            end
        }),
        VisibleConnection = Roact.createElement(ExternalEventConnection, {
            event = arg1.props.HubBar:GetPropertyChangedSignal("Visible"),
            callback = function()
                arg1.updateVisibleBinding(arg1.props.HubBar.Visible)
            end
        }),
        ViewportSizeChangedConnection = Roact.createElement(ExternalEventConnection, {
            event = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),
            callback = function()
                arg1:updateViewport()
            end
        }),
        UIPadding = Roact.createElement("UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingTop = UDim.new(0, 10) }),
        ImageButton = 0
    }
    local createElement2 = Roact.createElement
    local str2 = "ImageButton"

    local tbl3 = {
        Image = "",
        BorderSizePixel = 0,
        BackgroundColor3 = Theme.color("DefaultButton"),
        BackgroundTransparency = Theme.transparency("DefaultButton", 1),
        Position = UDim2.new(0, 0, 0, 0),
        Size = arg1.buttonHeightBinding:map(function(yOffset: number?): UDim2
            if yOffset then
                return UDim2.new(0, 0, 0, yOffset)
            end
            return UDim2.new()
        end),
        AutomaticSize = Enum.AutomaticSize.X,
        ScaleType = Enum.ScaleType.Stretch,
        SliceCenter = Rect.new(8, 6, 46, 44)
    }

    tbl3[Roact.Event.MouseEnter] = function(arg2)
        arg2.BackgroundColor3 = Theme.color("DefaultButtonHover")
        arg2.BackgroundTransparency = Theme.transparency("DefaultButtonHover")
    end
    tbl3[Roact.Event.MouseLeave] = function(arg2)
        arg2.BackgroundColor3 = Theme.color("DefaultButton")
        arg2.BackgroundTransparency = Theme.transparency("DefaultButton")
    end
    tbl3[Roact.Event.Activated] = function(_)
        FrontButtonController.initiateFrontButtonTeleport()
    end
    local tbl4 = {
        UICorner = Roact.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius }),
        UIStroke = Roact.createElement("UIStroke", {
            Color = Theme.color("DefaultButtonStroke"),
            Transparency = Theme.transparency("DefaultButtonStroke"),
            Thickness = Theme.DefaultStokeThickness
        }),
        Frame = 0
    }
    local createElement3 = Roact.createElement
    local str3 = "Frame"
    local tbl5 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 4, 0, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl6 = {
        UIPadding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 12) }),
        Container = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        TextLabel = Roact.createElement("TextLabel", {
            Text = arg1.state.text,
            Size = UDim2.new(0, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextYAlignment = Enum.TextYAlignment.Center,
            Font = Theme.font(Enum.Font.SourceSansBold, "Bold"),
            TextSize = arg1.textSizeBinding,
            TextScaled = true,
            TextWrapped = true,
            LayoutOrder = 1,
            [Roact.Ref] = arg1.textLabelRef
        }, {
            UITextSizeConstraint = Roact.createElement("UITextSizeConstraint", { MaxTextSize = arg1.textSizeConstraintBinding }),
            UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = arg1.sizeConstraintBinding })
        }),
        ImageLabel = 0
    }
    local element

    if FFlagCoreUiMigrateUIBloxToFoundation then
        element = Roact.createElement(
            Foundation.Icon,
            {
                name = "icons/actions/cycleRight",
                size = Foundation.Enums.IconSize.Large,
                LayoutOrder = 2
            }
        )
    else
        element = Roact.createElement(
            ImageSetLabel,
            {
                Image = Images["icons/actions/cycleRight"],
                Size = UDim2.new(1, 0, 0.75, 0),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                LayoutOrder = 2
            },
            {
                UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {})
            }
        )
    end

    tbl6.ImageLabel = element
    tbl4.Frame = createElement3(str3, tbl5, tbl6)
    tbl2.ImageButton = createElement2(str2, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

return var1
