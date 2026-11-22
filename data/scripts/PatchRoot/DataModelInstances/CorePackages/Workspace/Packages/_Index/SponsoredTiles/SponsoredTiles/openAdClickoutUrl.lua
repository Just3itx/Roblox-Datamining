-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SponsoredTilesParent = script:FindFirstAncestor("SponsoredTiles").Parent

local AppPage = require(SponsoredTilesParent.RobloxAppEnums).AppPage
local DiscoveryEventErrorLogger = require(SponsoredTilesParent.DiscoveryUtils).DiscoveryEventErrorLogger
local LinkingProtocol = require(SponsoredTilesParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default

local function openWebView(tbl1, detail: string)
    tbl1.navigate(AppPage.GenericWebPage, { detail = detail, extraProps = { showDomainAsTitle = true } })
end

local function openAdClickoutUrl(tbl1, detail: string)
    default:isURLRegistered(detail):catch(function(arg1): boolean
        DiscoveryEventErrorLogger.reportError("AdClickout_IsUrlRegisteredFailed", tostring(arg1))
        return false
    end):andThen(function(arg1)
        if not arg1 then
            openWebView(tbl1, detail)
            return
        end

        if default:isInternalDlicEnabled() then
            local var1 = default:createInternalDlic(detail, DeepLinkSource.LuaInternal)
            if var1 ~= nil and var1 ~= "" then
                default:detectDeeplinkIntent(var1)
                return
            end
            DiscoveryEventErrorLogger.reportError("AdClickout_CreateInternalDlicFailed", detail)
        end

        default:detectURL(detail)
    end):catch(function(arg1)
        DiscoveryEventErrorLogger.reportError("AdClickout_DeeplinkFailed", tostring(arg1))
    end)
end

return openAdClickoutUrl
