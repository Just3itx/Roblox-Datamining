-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local ContactImporterParent = ContactImporter.Parent
local React = require(ContactImporterParent.React)
local useNavigation = require(ContactImporterParent.Navigation).useNavigation

local useBeginContactImporter = require(ContactImporter.Hooks.useBeginContactImporter)

local function ContactImporterLandingPage()
    local entryPoint = (useNavigation().getParam("extraProps") or {}).entryPoint

    local _, var1 = useBeginContactImporter({ entryPoint = entryPoint })

    local var2 = React.useCallback(function()
        if var1 then
            var1()
        end
    end, { var1 })

    React.useEffect(function()
        var2()
    end, {})
end

return ContactImporterLandingPage
