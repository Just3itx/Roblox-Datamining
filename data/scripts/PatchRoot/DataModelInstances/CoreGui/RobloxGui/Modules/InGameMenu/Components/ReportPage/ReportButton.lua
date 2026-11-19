-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParentParent = script.Parent.Parent.Parent

local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local Assets = require(scriptParentParentParent.Resources.Assets)

local OpenReportDialog = require(scriptParentParentParent.Actions.OpenReportDialog)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local Image = Foundation.Image

local var3 = t.strictInterface({
    userId = t.optional(t.integer),
    userName = t.optional(t.string),
    LayoutOrder = t.integer,
    dispatchOpenReportDialog = t.callback
})

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        dispatchOpenReportDialog = function(arg1, arg2)
            callback(OpenReportDialog(arg1, arg2))
        end
    }
end)(function(arg1) -- name: ReportButton
    if GlobalConfig.propValidation then
        assert(var3(arg1))
    end

    return var1(function(arg2)
        if not FFlagCoreUiMigrateUIBloxToFoundation then
            local createElement = Roact.createElement
            local var4 = ImageSetButton
            local tbl1 = {
                Selectable = false,
                Image = Assets.Images.ReportIcon,
                Size = UDim2.new(0, 36, 0, 36),
                ImageColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                LayoutOrder = arg1.LayoutOrder,
                SelectionImageObject = arg2(var2.RoundedRectNoInset)
            }

            tbl1[Roact.Event.Activated] = function()
                arg1.dispatchOpenReportDialog(arg1.userId, arg1.userName)
            end

            return createElement(var4, tbl1)
        end

        return Roact.createElement(Image, {
            Image = Assets.Images.ReportIcon,
            Size = UDim2.new(0, 36, 0, 36),
            backgroundStyle = { Transparency = 1 },
            imageStyle = {
                Color3 = Color3.fromRGB(255, 255, 255),
                Transparency = 0
            },
            LayoutOrder = arg1.LayoutOrder,
            selection = {
                Selectable = false,
                SelectionImageObject = arg2(var2.RoundedRectNoInset)
            },
            onActivated = function()
                arg1.dispatchOpenReportDialog(arg1.userId, arg1.userName)
            end
        })
    end)
end)
