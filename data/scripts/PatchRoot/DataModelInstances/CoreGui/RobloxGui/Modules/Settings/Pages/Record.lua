-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")
local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local VRService = game:GetService("VRService")

RobloxGui:WaitForChild("Modules"):WaitForChild("TenFootInterface")
local Enums = require(CorePackages.Workspace.Packages.SocialLuaAnalytics).Analytics.Enums
local EventNames = require(CorePackages.Workspace.Packages.CapturesInExperience).Analytics.EventNames
local Utility = require(RobloxGui.Modules.Settings.Utility)
local Theme = require(RobloxGui.Modules.Settings.Theme)
local Create = require(CorePackages.Workspace.Packages.AppCommonLib).Create
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox

local Contexts = Enums.Contexts
local EventTypes = Enums.EventTypes

local function Initialize()
    local var1 = require(RobloxGui.Modules.Settings.SettingsPageFactory):CreateNewPage()
    local currentRecording = false

    local recordingEvent = Instance.new("BindableEvent")
    recordingEvent.Name = "RecordingEvent"
    var1.RecordingChanged = recordingEvent.Event
    function var1.IsRecording(_)
        return currentRecording
    end
    local iconsControlsScreenrecord = uiblox["icons/controls/screenrecord"]
    var1.TabHeader.TabLabel.Icon.Text = iconsControlsScreenrecord.name
    var1.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[iconsControlsScreenrecord.variant]
    var1.TabHeader.Name = "RecordTab"
    var1.TabHeader.TabLabel.Title.Text = "Record"

    local function onVREnabled() -- Luacid: Inlined by compiler; 1 call site recovered
        var1.TabHeader.Visible = not VRService.VREnabled
    end

    onVREnabled()
    VRService:GetPropertyChangedSignal("VREnabled"):connect(onVREnabled)

    var1.Page.Name = "Record"

    local function makeTextLabel(str1: string, string: string, bool1: boolean, page, layoutOrder: number)
        local xOffset = 10
        local num1 = 0
        local num2 = 10
        local var2 = Theme.textSize(24)
        local var3 = Theme.font(Enum.Font.SourceSans)

        if bool1 then
            xOffset = 10
            num1 = 0
            num2 = 0
            var2 = Theme.textSize(36)
            var3 = Theme.font(Enum.Font.SourceSansBold, "Bold")
        end

        local var4 = Create("Frame")(
            {
                Name = str1 .. "Container",
                BackgroundTransparency = 1,
                ZIndex = 2,
                LayoutOrder = layoutOrder,
                Parent = page
            }
        )
        local var5 = Create("TextLabel")({
            Name = str1,
            BackgroundTransparency = 1,
            Text = string,
            TextWrapped = true,
            Font = var3,
            TextSize = var2,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            Position = UDim2.new(0, xOffset, 0, 0),
            Size = UDim2.new(1, -(xOffset + num1), 1, 0),
            ZIndex = 2,
            Parent = var4
        })

        local function onResized(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            if arg1 == "AbsoluteSize" then
                local vector2 = TextService:GetTextSize(string, var5.TextSize, var5.Font, Vector2.new(page.AbsoluteSize.X - xOffset - num1, 10000))
                var4.Size = UDim2.new(1, 0, 0, vector2.Y + num2)
            end
        end

        onResized("AbsoluteSize")
        page.Changed:connect(onResized)

        return var5, var4
    end

    function var1.SetHub(_, hubRef)
        var1.HubRef = hubRef

        local function func1()
            var1.HubRef:SetVisibility(false, true)
        end

        makeTextLabel("ScreenshotTitle", "Screenshot", true, var1.Page, 1)
        makeTextLabel(
            "ScreenshotBody",
            "By clicking the 'Take Screenshot' button, the menu will close and take a screenshot and save it to your computer.",
            false,
            var1.Page,
            2
        )
        local var2 = var1
        local var3 = var1
        local screenshotButtonRow, screenshotButton = Utility:AddButtonRow(var1, "ScreenshotButton", "Take Screenshot", UDim2.new(0, 300, 0, 44), func1)
        var2.ScreenshotButtonRow = screenshotButtonRow
        var3.ScreenshotButton = screenshotButton
        var1.ScreenshotButtonRow.LayoutOrder = 3

        makeTextLabel("VideoTitle", "Video", true, var1.Page, 4)
        makeTextLabel(
            "VideoBody",
            "By clicking the 'Record Video' button, the menu will close and start recording your screen.",
            false,
            var1.Page,
            5
        )
        local var6, var7 = Utility:AddButtonRow(var1, "RecordButton", "Record Video", UDim2.new(0, 300, 0, 44), func1)
        var6.LayoutOrder = 6
        var7.MouseButton1Click:connect(function()
            RbxAnalyticsService:SendEventDeferred("mobile", Contexts.Captures, EventTypes.ButtonClick, {
                btn = if currentRecording then EventNames.CapturesLegacyVideoRecordDeactivated else EventNames.CapturesLegacyVideoRecordActivated
            })
            recordingEvent:Fire(not currentRecording)
        end)

        local gameOptions = settings():FindFirstChild("Game Options")
        if gameOptions then
            gameOptions.VideoRecordingChangeRequest:connect(function(recording: boolean)
                currentRecording = recording
                if recording then
                    var7.RecordButtonTextLabel.Text = "Stop Recording"
                    return
                end
                var7.RecordButtonTextLabel.Text = "Record Video"
            end)
        end

        var7.Activated:Connect(function()
            CoreGui:ToggleRecording()
        end)
        var1.ScreenshotButton.Activated:Connect(function()
            CoreGui:TakeScreenshot()
        end)

        var1.Page.Size = UDim2.new(1, 0, 0, 400)
    end

    return var1
end

local var1 = Initialize()

var1.Displayed.Event:connect(function(arg1)
    if arg1 then
        GuiService.SelectedCoreObject = var1.ScreenshotButton
    end
end)

return var1
