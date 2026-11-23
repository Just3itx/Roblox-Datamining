-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:04:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperiencePlaytestLaunch = script:FindFirstAncestor("BuildExperiencePlaytestLaunch")
local BuildExperiencePlaytestLaunchParent = BuildExperiencePlaytestLaunch.Parent

local LinkingProtocol = require(BuildExperiencePlaytestLaunchParent.LinkingProtocol)
local leaveExperience = require(BuildExperiencePlaytestLaunch.leaveExperience)

local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default

local function openDeepLink(str1: string, bool1: boolean)
    if default:isInternalDlicEnabled() then
        local var1 = default:createInternalDlic(str1, DeepLinkSource.LuaInternal)
        if bool1 then
            leaveExperience(function()
                default:detectDeeplinkIntent(var1)
            end)

            return
        end

        default:detectDeeplinkIntent(var1)
    elseif bool1 then
        leaveExperience(function()
            default:detectURL(str1)
        end)
    else
        default:detectURL(str1)
    end
end

return openDeepLink
