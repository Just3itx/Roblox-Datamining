-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)

local tbl1 = {
    ["Feature.RobloxSubscription.Description.ExclusiveBenefits"] = "Lorem ipsum dolor sit amet consectetur",
    ["Feature.RobloxSubscription.Action.Subscribe"] = "Lorem"
}

local function usePlaceholderLocalization(tbl2)
    return React.useMemo(function()
        local result = ({})
        for k, value in pairs(tbl2) do
            local var1 = if typeof(value) == "table" then value[1] else value
            local var2 = tbl1[var1] or var1
            if typeof(value) == "table" then
                for k2, value2 in pairs(value) do
                    if typeof(k2) == "string" then
                        var2 = string.gsub(var2, "{" .. k2 .. "}", function(): string
                            return tostring(value2)
                        end)
                    end
                end
            end
            result[k] = var2
        end
        return result
    end, { tbl2 })
end

return usePlaceholderLocalization
