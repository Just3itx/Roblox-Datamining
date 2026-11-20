-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CorePackages = game:GetService("CorePackages")

local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local TweenService = game:GetService("TweenService")

local Utility = require(RobloxGui.Modules.Settings.Utility)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local AppCommonLib = require(CorePackages.Workspace.Packages.AppCommonLib)
local Create = AppCommonLib.Create
local Signal = AppCommonLib.Signal

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local FFlagResponsiveUnitsDeprecateTenFoot = SharedFlags.FFlagResponsiveUnitsDeprecateTenFoot
local var1 = require(RobloxGui.Modules.TenFootInterface):IsEnabled() and not FFlagResponsiveUnitsDeprecateTenFoot

local GetFFlagFixIGMTabTransitions = require(script.Parent.Flags.GetFFlagFixIGMTabTransitions)
local FFlagIEMFocusNavSupportNewButtons = require(script.Parent.Flags.FFlagIEMFocusNavSupportNewButtons)

local FFlagIEMTabFocusNav = SharedFlags.FFlagIEMTabFocusNav
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)

local function Initialize()
    local module = {
        HubRef = nil,
        LastSelectedObject = nil,
        TabPosition = 0,
        Active = false,
        OpenStateChangedCount = 0,
        ShouldShowBottomBar = not isSideSheetEnabled,
        ShouldShowHubBar = true,
        ShouldDisableDefaultScroll = false,
        IsPageClipped = true,
        SelectARow = nil,
        LastSelectableObjectsUpdated = Signal.new(),
        LastSelectableObjects = {},
        PageNextSelectionDown = nil
    }

    if FFlagIEMTabFocusNav then
        module.FirstSelectableObjectsUpdated = Signal.new()
        module.FirstSelectableObjects = {}
    end
    local rows = {}
    local displayed = false

    module.TabHeader = Create("TextButton")({
        Name = "Header",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Selectable = not not FFlagIEMTabFocusNav
    })
    if Utility:IsSmallTouchScreen() then
        module.TabHeader.Size = UDim2.new(0, 84, 1, 0)
    elseif var1 then
        module.TabHeader.Size = UDim2.new(0, 220, 1, 0)
    end
    if FFlagIEMTabFocusNav then
        local function switchToPage()
            if module.HubRef and module.HubRef.Pages.CurrentPage ~= module then
                module.HubRef:SwitchToPage(module, true)
            end
        end
        module.TabHeader.Activated:connect(switchToPage)
        module.TabHeader.SelectionGained:connect(switchToPage)
    else
        module.TabHeader.MouseButton1Click:connect(function()
            if module.HubRef then
                module.HubRef:SwitchToPage(module, true)
            end
        end)
    end

    local var2 = Create("TextLabel")({
        Name = "Icon",
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 0.5, 0),
        Position = UDim2.new(0, 10, 0.5, -18),
        Text = "",
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = true,
        TextTransparency = 0.5,
        Parent = module.TabHeader
    })
    Create("UIAspectRatioConstraint")({ Name = "AspectRatioConstraint", AspectRatio = 1, Parent = var2 })

    local var3 = Create("TextLabel")({
        Name = "Title",
        Text = "",
        Font = Theme.font(Enum.Font.SourceSansBold, "Button"),
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Size = UDim2.new(1.05, 0, 1, 0),
        Position = UDim2.new(1.2, Theme.TabHeaderIconPadding, 0, -2),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = 0.5
    })

    var3.TextSize = Theme.textSize(24)
    local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")
    uiTextSizeConstraint.MaxTextSize = Theme.textSize(24)
    var3.Parent = var2
    if Utility:IsPortrait() and Utility:IsSmallTouchScreen() then
        uiTextSizeConstraint.Parent = var3
    end

    if Utility:IsSmallTouchScreen() then
        var3.TextSize = Theme.textSize(18)
        uiTextSizeConstraint.MaxTextSize = Theme.textSize(18)
    elseif var1 then
        var3.TextSize = Theme.textSize(48)
        uiTextSizeConstraint.MaxTextSize = Theme.textSize(48)
    end

    Create("ImageLabel")({
        Name = "TabSelection",
        Visible = false,
        BackgroundColor3 = Theme.color("TabSelection"),
        BackgroundTransparency = Theme.transparency("TabSelection"),
        Size = UDim2.new(1, -2, 0, 2),
        Position = UDim2.new(0, 3, 1, -2),
        BorderSizePixel = 0,
        Parent = module.TabHeader
    })

    local var4 = Create("Frame")({
        Name = "TabLabel",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = module.TabHeader
    })
    Create("UIListLayout")({
        Name = "Layout",
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        Parent = var4
    })

    var2.Parent = var4
    var3.Parent = var4
    var3.Size = UDim2.new(0, 0, 0, 0)
    var3.AutomaticSize = Enum.AutomaticSize.XY

    Utility:OnResized(module.TabHeader, function() -- name: onResized
        if not module.TabHeader then
            return
        end

        if Utility:IsSmallTouchScreen() then
            var2.Size = UDim2.new(0, 34, 0, 28)
        elseif var1 then
            var2.Size = UDim2.new(0, 88, 0, 74)
        else
            local iconSize = Theme.getIconSize(Theme.IconSize.Medium)
            var2.Size = UDim2.fromOffset(iconSize, iconSize)
        end

        local isPortrait = Utility:IsPortrait()
        local layout = var4.Layout
        if isPortrait then
            if Utility:IsSmallTouchScreen() then
                var3.FontSize = Theme.fontSize(Enum.FontSize.Size14)
            end
            var2.Size = UDim2.new(0, 22, 0, 22)
            layout.FillDirection = Enum.FillDirection.Vertical
            layout.Padding = UDim.new(0, 0)
        else
            if Utility:IsSmallTouchScreen() then
                var3.FontSize = Theme.fontSize(Enum.FontSize.Size18)
            end
            layout.FillDirection = Enum.FillDirection.Horizontal
            layout.Padding = UDim.new(0, 10)
        end

        var2.Size = UDim2.fromOffset(var2.Size.X.Offset * (2 / 3), var2.Size.Y.Offset * (2 / 3))
    end)

    module.Page = Create("Frame")(
        {
            Name = "Page",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
    )
    Create("UIPadding")({ PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 11), Parent = module.Page })

    module.PageListLayout = Create("UIListLayout")({
        Name = "RowListLayout",
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = module.Page
    })
    module.Page.SelectionGroup = true

    module.Displaying = Instance.new("BindableEvent")
    module.Displaying.Name = "Displaying"

    module.Displayed = Instance.new("BindableEvent")
    module.Displayed.Name = "Displayed"

    module.Displayed.Event:connect(function()
        if not module.HubRef.Shield.Visible then
            return
        end
        module:SelectARow()
    end)

    module.Hidden = Instance.new("BindableEvent")
    module.Hidden.Event:connect(function()
        if GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(module.Page) then
            GuiService.SelectedCoreObject = nil
        end
    end)
    module.Hidden.Name = "Hidden"

    function module.getValueChangerFrame(_, arg1)
        if type(arg1) == "table" then
            return arg1.SliderFrame and arg1.SliderFrame or arg1.SelectorFrame or arg1.DropDownFrame
        end

        return arg1
    end

    function module.SelectARow(_, arg1)
        if FFlagIEMTabFocusNav and not arg1 and GuiService.SelectedCoreObject == module.TabHeader then
            return
        end
        if not arg1 and GuiService.SelectedCoreObject and GuiService.SelectedCoreObject:IsDescendantOf(module.Page) then
            return
        end
        if module.LastSelectedObject then
            GuiService.SelectedCoreObject = module.LastSelectedObject
            return
        end
        if not rows or not (#rows > 0) then
            if module.PageNextSelectionDown
                and (not FFlagIEMFocusNavSupportNewButtons or module.PageNextSelectionDown:IsDescendantOf(CoreGui))
            then
                GuiService.SelectedCoreObject = module.PageNextSelectionDown
            end

            return
        end

        local huge = math.huge
        local valueChanger = rows[1].ValueChanger
        for _, value in rows do
            if value.SelectionFrame and value.SelectionFrame.LayoutOrder < huge then
                huge = value.SelectionFrame.LayoutOrder
                valueChanger = value
            end
        end

        GuiService.SelectedCoreObject = module:getValueChangerFrame(valueChanger.ValueChanger)
    end

    function module.Display(_, arg1, arg2)
        module.OpenStateChangedCount += 1

        if module.TabHeader then
            module.TabHeader.TabSelection.Visible = true
            var2.TextTransparency = 0
            var3.TextTransparency = 0
        end

        module.Page.Parent = arg1
        module.Page.Visible = true

        module.Displaying:Fire()

        local uDim2 = UDim2.new(0, 0, 0, 0)
        local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
            if UserGameSettings.ReducedMotion then
                arg1.InnerCanvasGroupShow.Visible = false
            end
            if GetFFlagFixIGMTabTransitions() then
                if UserGameSettings.ReducedMotion then
                    arg1.InnerCanvasGroupShow.GroupTransparency = 0
                end
                module.Page.Position = uDim2
            end
            module.Page.Visible = true
            displayed = true
            module.Displayed:Fire()
        end
        if arg2 then
            module.Page.Position = uDim2
            func1()
            return
        end
        if not UserGameSettings.ReducedMotion then
            module.Page:TweenPositionInternal(uDim2, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true, func1)
            return
        end

        module.Page.Position = uDim2
        arg1.InnerCanvasGroupShow.GroupTransparency = 1
        arg1.InnerCanvasGroupShow.Visible = true
        module.Page.Parent = arg1.InnerCanvasGroupShow
        module.Page.Visible = true

        local tweenInfo = TweenInfo.new(0.25)
        local tween = TweenService:Create(arg1.InnerCanvasGroupShow, tweenInfo, { GroupTransparency = 0 })
        tween:Play()

        tween.Completed:Connect(function()
            module.Page.Parent = arg1
            func1()
        end)
    end

    function module.Hide(_, arg1, arg2, arg3, arg4, arg5, arg6)
        module.OpenStateChangedCount += 1

        if module.TabHeader then
            module.TabHeader.TabSelection.Visible = false
            var2.TextTransparency = 0.5
            var3.TextTransparency = 0.5
        end

        if not module.Page.Parent then
            return
        end

        local uDim2 = UDim2.new(1 * arg1, 0, 0, 0)
        local function func1() -- Luacid: Inlined by compiler; 2 call sites recovered
            if UserGameSettings.ReducedMotion and arg6 then
                arg5.InnerCanvasGroupHide.Visible = false
            end
            module.Page.Visible = false
            module.Page.Position = UDim2.new(module.TabPosition - arg2, 0, 0, 0)
            displayed = false
            module.Hidden:Fire()
        end

        local function func2()
            if arg3 then
                module.Page.Position = uDim2
                func1()
                return
            end
            if not UserGameSettings.ReducedMotion or not arg6 then
                module.Page:TweenPositionInternal(uDim2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, func1)
                return
            end

            arg5.InnerCanvasGroupHide.GroupTransparency = 0
            arg5.InnerCanvasGroupHide.Visible = true
            module.Page.Parent = arg5.InnerCanvasGroupHide

            local tweenInfo = TweenInfo.new(0.25)
            local tween = TweenService:Create(arg5.InnerCanvasGroupHide, tweenInfo, { GroupTransparency = 1 })
            tween:Play()

            tween.Completed:Connect(function()
                module.Page.Parent = arg5
                module.Page.Position = uDim2
                func1()
            end)
        end

        if not arg4 then
            func2()
            return
        end

        local openStateChangedCount = module.OpenStateChangedCount
        delay(arg4, function()
            if openStateChangedCount == module.OpenStateChangedCount then
                func2()
            end
        end)
    end

    function module.GetDisplayed(_)
        return displayed
    end

    function module.GetVisibility(_)
        return module.Page.Parent
    end

    function module.GetTabHeader(_)
        return module.TabHeader
    end

    function module.GetRows(_)
        return rows
    end

    function module.SetHub(_, hubRef)
        module.HubRef = hubRef

        for _, value in next, rows do
            if type(value.ValueChanger) == "table" then
                value.ValueChanger.HubRef = module.HubRef
            end
        end
    end

    function module.GetSize(_)
        return module.Page.AbsoluteSize
    end

    function module.AddRow(_, selectionFrame, label, valueChanger, arg1)
        rows[#rows + 1] = {
            SelectionFrame = selectionFrame,
            Label = label,
            ValueChanger = valueChanger
        }

        local var5 = if selectionFrame then selectionFrame.Size.Y.Offset else 0

        if arg1 then
            module.Page.Size = UDim2.new(1, 0, 0, module.Page.Size.Y.Offset + var5 + arg1)
        else
            module.Page.Size = UDim2.new(1, 0, 0, module.Page.Size.Y.Offset + var5)
        end

        if module.HubRef and type(valueChanger) == "table" then
            valueChanger.HubRef = module.HubRef
        end
    end

    return module
end

local module = {}

function module.CreateNewPage(_)
    return (Initialize())
end

return module
