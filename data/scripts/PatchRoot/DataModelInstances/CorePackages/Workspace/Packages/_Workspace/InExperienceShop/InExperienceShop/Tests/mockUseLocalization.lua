-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local jest = require(InExperienceShopParent.Dev.JestGlobals).jest

local function mockUseLocalization()
    jest.mock(InExperienceShopParent.Localization, function()
        return {
            Hooks = {
                useLocalization = function(tbl1)
                    local result = ({})
                    for value, value2 in tbl1 do
                        if typeof(value2) == "table" then
                            result[value] = value2[1]
                        else
                            result[value] = value2
                        end
                    end
                    return result
                end
            },
            NumberLocalization = {
                localize = function(str1: string, _: string): string
                    return str1
                end
            }
        }
    end)
end

return mockUseLocalization
