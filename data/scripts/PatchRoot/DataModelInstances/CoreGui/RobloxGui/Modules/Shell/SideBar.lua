-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Shell = game:GetService("CoreGui"):FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local CorePackages = game:GetService("CorePackages")

local GlobalSettings = require(Shell:FindFirstChild("GlobalSettings"))
local Utility = require(Shell:FindFirstChild("Utility"))
local ScreenManager = require(Shell:FindFirstChild("ScreenManager"))
local SoundManager = require(Shell:FindFirstChild("SoundManager"))
local Analytics = require(Shell:FindFirstChild("Analytics"))
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create

return function()
    local module = {}

    local tbl1 = ({})
    local var1 = nil
    local isFocused = false

    local var2 = Create("Frame")({
        Name = "ModalOverlay",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BackgroundColor3 = GlobalSettings.ModalBackgroundColor,
        BorderSizePixel = 0,
        ZIndex = 4
    })

    local selectionParent = Create("Frame")({
        Name = "SideBarContainer",
        Size = UDim2.new(0.3, 0, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = GlobalSettings.OverlayColor,
        ZIndex = 5,
        Parent = var2
    })

    local selectionImageObject = Create("TextButton")({
        Name = "DummySelectionImage",
        Size = UDim2.new(0, 0, 0, 0),
        Visible = false,
        SoundManager:CreateSound("MoveSelection")
    })

    local var4 = Create("TextLabel")({
        Name = "Text",
        Size = UDim2.new(1, -165, 1, -156),
        Position = UDim2.new(0, 65, 0, 156),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ZIndex = 6,
        Text = "",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextColor3 = GlobalSettings.WhiteTextColor,
        Font = GlobalSettings.RegularFont,
        FontSize = GlobalSettings.DescriptionSize,
        TextWrapped = true
    })

    local function recalcPositions()
        for i = 1, #tbl1 do
            tbl1[i].Position = UDim2.new(0, 0, 0, (i - 1) * 75 + 156)
        end
    end

    local closedEvent = Instance.new("BindableEvent")
    closedEvent.Name = "ClosedEvent"
    module.Closed = closedEvent.Event

    function module.GetAnalyticsInfo(_)
        return {
            [Analytics.WidgetNames("WidgetId")] = Analytics.WidgetNames("SideBarId")
        }
    end
    function module.AddItem(_, text, callback)
        local var5 = Create("TextButton")({
            Name = "SortButton",
            Size = UDim2.new(1, 0, 0, 75),
            BorderSizePixel = 0,
            BackgroundColor3 = GlobalSettings.BlueButtonColor,
            BackgroundTransparency = 1,
            ZIndex = 6,
            Text = "",
            SelectionImageObject = selectionImageObject,
            Parent = selectionParent,
            SoundManager:CreateSound("MoveSelection")
        })

        local var6 = Create("TextLabel")({
            Name = "SortName",
            Size = UDim2.new(1, -65, 1, 0),
            Position = UDim2.new(0, 65, 0, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = GlobalSettings.WhiteTextColor,
            Font = GlobalSettings.RegularFont,
            FontSize = GlobalSettings.MediumFontSize,
            ZIndex = 7,
            Parent = var5
        })

        var5.MouseButton1Click:connect(function()
            SoundManager:Play("ButtonPress")
            ScreenManager:CloseCurrent(module)
            closedEvent:Fire()
            callback()
        end)
        var5.SelectionGained:connect(function()
            var5.BackgroundTransparency = 0
            var6.TextColor3 = GlobalSettings.TextSelectedColor
        end)
        var5.SelectionLost:connect(function()
            var5.BackgroundTransparency = 1
            var6.TextColor3 = GlobalSettings.WhiteTextColor
        end)

        tbl1[#tbl1 + 1] = var5
        recalcPositions()
    end

    function module.SetText(_, text)
        var4.Text = text
        var4.Parent = selectionParent
    end

    function module.ResetText(_)
        var4.Text = ""
        var4.Parent = nil
    end

    function module.RemoveAllItems(_)
        module:ResetText()
        for k, value in pairs(tbl1) do
            value:Destroy()
            tbl1[k] = nil
        end
    end

    function module.SetSelectedObject(_, arg1, arg2)
        if #tbl1 > 0 then
            var1 = arg1 and tbl1[arg1] or tbl1[1]

            if arg2 == true and var1 and isFocused then
                GuiService.SelectedCoreObject = var1
            end
        else
            var1 = nil
        end
    end

    function module.GetPriority(_)
        return GlobalSettings.OverlayPriority
    end

    function module.Show(arg1)
        var2.Parent = ScreenManager:GetScreenGuiByPriority(arg1:GetPriority())
        Utility.PropertyTweener(
            var2,
            "BackgroundTransparency",
            1,
            GlobalSettings.ModalBackgroundTransparency,
            0.25,
            Utility.EaseInOutQuad,
            true,
            nil
        )
        selectionParent:TweenPositionInternal(
            UDim2.new(1 - selectionParent.Size.X.Scale, 0, 0, 0),
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Quad,
            0.25,
            true,
            nil
        )
        SoundManager:Play("SideMenuSlideIn")
    end

    function module.Hide(_)
        Utility.PropertyTweener(var2, "BackgroundTransparency", 0.3, 1, 0.25, Utility.EaseInOutQuad, true, function()
            var2.Parent = nil
        end)
        selectionParent:TweenPositionInternal(
            UDim2.new(1, 0, 0, 0),
            Enum.EasingDirection.InOut,
            Enum.EasingStyle.Sine,
            0.25,
            true
        )
    end
    function module.IsFocused(_)
        return isFocused
    end

    function module.Focus(arg1)
        isFocused = true
        GuiService:AddSelectionParent("SideBar", selectionParent)
        if var1 then
            Utility.SetSelectedCoreObject(var1)
        else
            arg1:SetSelectedObject(1)
            Utility.SetSelectedCoreObject(var1)
        end

        ContextActionService:BindCoreAction("CloseSideBar", function(_, userInputState, _)
            if userInputState == Enum.UserInputState.End then
                ScreenManager:CloseCurrent(module)
                closedEvent:Fire()
            end
        end, false, Enum.KeyCode.ButtonB)
    end

    function module.RemoveFocus(_)
        isFocused = false
        GuiService:RemoveSelectionGroup("SideBar")
        ContextActionService:UnbindCoreAction("CloseSideBar")
        var1 = nil
    end

    return module
end
