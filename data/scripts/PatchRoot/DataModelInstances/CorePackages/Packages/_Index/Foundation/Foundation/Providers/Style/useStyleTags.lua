-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:13Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local TagsContext = require(scriptParent.TagsContext)
local getFormattedTags = require(Foundation.Utility.getFormattedTags)

local _Types = require(Foundation.Components.Types)

local function useStyleTags(arg1)
    local formattedTags = getFormattedTags(arg1)

    local var1 = React.useContext(TagsContext)
    React.useLayoutEffect(function()
        if formattedTags ~= nil then
            var1(string.split(formattedTags, " "))
        end
    end, { formattedTags, var1 })
    return formattedTags
end

return useStyleTags
