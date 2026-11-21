-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.dependencies).React
local ContactImporterAnalyticsContext = require(script.Parent.ContactImporterAnalyticsContext)

return function()
    return React.useContext(ContactImporterAnalyticsContext)
end
