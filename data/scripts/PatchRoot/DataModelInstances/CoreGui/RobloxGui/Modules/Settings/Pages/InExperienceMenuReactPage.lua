-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local SettingsShowSignal = require(CorePackages.Workspace.Packages.CoreScriptsCommon).SettingsShowSignal

local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local scriptParentParent = script.Parent.Parent

local EnumReactPage = require(scriptParentParent.EnumReactPage)
local PortalWithFoundationStylelink = require(scriptParentParent.Components.PortalWithFoundationStylelink)
local ReactPageSignal = require(scriptParentParent.ReactPageSignal)
local TraversalHistoryPage = require(scriptParentParent.Components.Traversal).TraversalHistoryPage

return React.memo(React.forwardRef(function(tbl1, _) -- name: InExperienceMenuReactPage
    local var1 = ReactPageSignal(false)
    local var2 = SignalsReact.useSignalState(var1.currentReactPage)
    local page = if var2 == EnumReactPage.TraversalHistory then React.createElement(TraversalHistoryPage) else nil

    React.useEffect(function()
        if var2 then
            tbl1.onMount()
            return tbl1.onUnmount
        end
    end, { var2 })

    React.useEffect(function()
        local connection = SettingsShowSignal:connect(function(arg1)
            if not arg1 then
                tbl1.onUnmount()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, {})

    return React.createElement(PortalWithFoundationStylelink, { parent = tbl1.mountTo }, { Page = page })
end))
