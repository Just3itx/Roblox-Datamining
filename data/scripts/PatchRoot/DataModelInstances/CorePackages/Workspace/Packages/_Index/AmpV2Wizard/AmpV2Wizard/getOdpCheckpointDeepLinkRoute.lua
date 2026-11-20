-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPage = require(script.Parent.Parent.RobloxAppEnums).AppPage

return function(tbl1): {{{extraProps: {flow: {name: string, props: {odpSessionId: string}}, surface: string}, name: any}}}?
    local odpSessionId = tbl1.odpSessionId

    return if type(odpSessionId) == "string"
        and string.match(odpSessionId, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then {{{
        name = AppPage.AmpV2Wizard,
        extraProps = {
            flow = {
                name = "OdpCheckpointResume",
                props = { odpSessionId = odpSessionId }
            },
            surface = "OdpWebViewHandoff"
        }
    }}} else nil
end
