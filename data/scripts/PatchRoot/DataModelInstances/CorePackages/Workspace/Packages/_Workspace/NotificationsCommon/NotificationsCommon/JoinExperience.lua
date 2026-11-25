-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LinkingProtocol = require(scriptParentParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default

local isSubjectToDesktopPolicies = require(scriptParentParent.SharedFlags).isSubjectToDesktopPolicies

return function(arg1, arg2): boolean
    return pcall(function()
        if not arg2 then
            default:isURLRegistered(arg1):andThen(function(arg3)
                if not arg3 then
                    return
                end

                if default:isInternalDlicEnabled() then
                    local var1 = default:createInternalDlic(arg1, DeepLinkSource.LuaInternal)
                    default:detectDeeplinkIntent(var1)
                else
                    default:detectURL(arg1)
                end
            end)

            return
        end

        if default:isInternalDlicEnabled() then
            local var1 = default:createInternalDlic(arg1, DeepLinkSource.LuaInternal)
            if not isSubjectToDesktopPolicies() then
                game:Shutdown()
            end
            default:isURLRegistered(arg1):andThen(function(arg3)
                if arg3 then
                    default:detectDeeplinkIntent(var1)
                    return
                end

                game:Shutdown()
                default:detectDeeplinkIntent(var1)
            end)

            return
        end

        if not isSubjectToDesktopPolicies() then
            game:Shutdown()
        end
        default:isURLRegistered(arg1):andThen(function(arg3)
            if arg3 then
                default:detectURL(arg1)
                return
            end

            game:Shutdown()
            default:detectURL(arg1)
        end)
    end)
end
