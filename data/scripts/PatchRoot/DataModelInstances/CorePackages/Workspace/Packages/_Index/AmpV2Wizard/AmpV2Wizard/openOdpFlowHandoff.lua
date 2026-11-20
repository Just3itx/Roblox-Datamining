-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local AppPage = require(scriptParentParent.RobloxAppEnums).AppPage
local NavigationRodux = require(scriptParentParent.NavigationRodux)
local FFlagSignalsNavP3Dispatch = require(scriptParentParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = require(scriptParentParent.RobloxAppNavigation).NavigationCommands

return function(extraProps)
    return function(arg1)
        local tbl1 = {
            name = AppPage.AmpV2Wizard,
            extraProps = extraProps
        }
        local var1 = if FFlagSignalsNavP3Dispatch then NavigationRodux.GetLegacyNavigationStore(false).getCurrentPage(false) else NavigationRodux.Selectors.selectCurrentLegacyPage(arg1:getState())
        local extraProps2 = var1.extraProps
        local odpSessionId = if extraProps.flow and extraProps.flow.name == "OdpCheckpointResume" then extraProps.flow.props.odpSessionId else nil

        if odpSessionId
            and var1.name == AppPage.AmpV2Wizard
            and extraProps2
            and extraProps2.flow
            and extraProps2.flow.name == "OdpCheckpointResume"
            and extraProps2.flow.props.odpSessionId == odpSessionId
        then
            return
        end
        local bool1 = var1.name == AppPage.GenericWebPage
        if FFlagSignalsNavP3Dispatch then
            if bool1 then
                NavigationCommands.fromWebView(NavigationCommands.fromLegacyPage(tbl1), true)
                return
            end
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1), true)
        elseif bool1 then
            arg1:dispatch(NavigationRodux.Thunks.NavigateFromWebView(tbl1, true))
        else
            arg1:dispatch(NavigationRodux.Thunks.NavigateDown(tbl1, true))
        end
    end
end
