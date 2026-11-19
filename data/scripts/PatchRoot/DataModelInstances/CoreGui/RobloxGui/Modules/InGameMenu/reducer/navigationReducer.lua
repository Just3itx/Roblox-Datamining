-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.InGameMenuDependencies).Cryo
local scriptParentParent = script.Parent.Parent
local Pages = require(scriptParentParent.Components.Pages)
local NavigateBack = require(scriptParentParent.Actions.NavigateBack)
local SetCurrentPage = require(scriptParentParent.Actions.SetCurrentPage)

return function(arg1, arg2)
    local var1 = Pages.pagesByKey[arg1.menuPage]

    if arg2.type == NavigateBack.name then
        if arg1.respawn.dialogOpen then
            return Cryo.Dictionary.join(arg1, { respawn = Cryo.Dictionary.join(arg1.respawn, { dialogOpen = false }) })
        end

        if arg1.report.dialogOpen then
            return Cryo.Dictionary.join(arg1, { report = Cryo.Dictionary.join(arg1.report, { dialogOpen = false }) })
        end

        if arg1.menuPage then
            local parentPage = var1.parentPage
            if parentPage ~= nil then
                return Cryo.Dictionary.join(arg1, { menuPage = parentPage })
            end
        end
    elseif arg2.type == SetCurrentPage.name then
        return Cryo.Dictionary.join(arg1, { currentlyOpenBubble = Cryo.None })
    end

    return arg1
end
