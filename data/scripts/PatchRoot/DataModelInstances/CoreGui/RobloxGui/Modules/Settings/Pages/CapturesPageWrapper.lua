-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local Modules = CoreGui:WaitForChild("RobloxGui").Modules

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local SettingsPageFactory = require(Modules.Settings.SettingsPageFactory)
local var1 = require(CorePackages.Workspace.Packages.Chrome).Enabled()
local BuilderIcons = require(CorePackages.Packages.BuilderIcons)
local uiblox = BuilderIcons.Migration.uiblox
local Foundation = require(CorePackages.Packages.Foundation)

local GetFFlagFixIGMTabTransitions = require(script.Parent.Parent.Flags.GetFFlagFixIGMTabTransitions)
local FFlagIGMChangeCapturesToGallery = require(script.Parent.Parent.Flags.FFlagIGMChangeCapturesToGallery)
local FFlagIGMChangeGalleryHeaderIcon = require(script.Parent.Parent.Flags.FFlagIGMChangeGalleryHeaderIcon)
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)

local var2 = SettingsPageFactory:CreateNewPage()

var2.TabHeader.Name = "CapturesTab"
local tbl1 = if FFlagIGMChangeGalleryHeaderIcon then {
    name = "image",
    variant = Foundation.Enums.IconVariant.Regular
} elseif var1 then uiblox["icons/controls/cameraOff"] else uiblox["icons/controls/screenshot"]
var2.TabHeader.TabLabel.Icon.Text = tbl1.name
var2.TabHeader.TabLabel.Icon.FontFace = BuilderIcons.Font[tbl1.variant]

var2.TabHeader.TabLabel.Title.AutoLocalize = false
if FFlagIGMChangeCapturesToGallery then
    var2.TabHeader.TabLabel.Title.Text = RobloxTranslator:FormatByKey("Feature.Captures.Title.Gallery")
else
    var2.TabHeader.TabLabel.Title.Text = RobloxTranslator:FormatByKey("Feature.SettingsHub.Label.Captures")
end

var2.PageListLayout.Parent = nil
var2.ShouldShowBottomBar = not isSideSheetEnabled
var2.ShouldShowHubBar = true

var2.Page.Name = "Captures"
var2.Page.Size = UDim2.fromScale(1, 0)

local uiPadding = var2.Page:FindFirstChildWhichIsA("UIPadding")
if uiPadding then
    uiPadding:Destroy()
end

function var2.ConnectHubToApp(_, arg1, arg2, arg3)
    var2:SetHub(arg1)

    local yOffset = arg2.AbsoluteSize.Y - 20
    var2.Page.Size = UDim2.new(1, 0, 0, yOffset)
    arg2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        yOffset = arg2.AbsoluteSize.Y - 20
        var2.Page.Size = UDim2.new(1, 0, 0, yOffset)
    end)

    local display = var2.Display
    function var2.Display(_, ...)
        arg3.openMenu()
        display(var2, ...)
    end

    var2.Hidden.Event:Connect(function()
        if not GetFFlagFixIGMTabTransitions() then
            arg3.closeMenu()
        end
    end)

    local hide = var2.Hide
    function var2.Hide(_, ...)
        if GetFFlagFixIGMTabTransitions() then
            arg3.closeMenu()
        end
        hide(var2, ...)
    end
end

return var2
